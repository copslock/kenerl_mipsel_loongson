Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 21:00:04 +0100 (CET)
Received: from smtp-out-179.synserver.de ([212.40.185.179]:1102 "EHLO
        smtp-out-179.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011895AbbASUADCS7Z0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 21:00:03 +0100
Received: (qmail 20529 invoked by uid 0); 19 Jan 2015 20:00:02 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 20306
Received: from ppp-88-217-3-222.dynamic.mnet-online.de (HELO ?192.168.178.21?) [88.217.3.222]
  by 217.119.54.81 with AES256-SHA encrypted SMTP; 19 Jan 2015 20:00:02 -0000
Message-ID: <54BD62B5.7050205@metafoo.de>
Date:   Mon, 19 Jan 2015 21:01:57 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
MIME-Version: 1.0
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.de>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 01/19/2015 07:55 PM, Wolfram Sang wrote:
[...]
>
> Let's get rid of this code before really nobody knows/understands
> anymore what this was for and if it has a subtle use.

Getting rid of this is the right thing, cause it's just not how it should be 
done, but unfortunately it is not as simple as this. The problem is that the 
adapter is typically embedded in the parent device's state struct. This state 
struct is typically freed directly after calling i2c_del_adapter(). If there is 
still something holding a reference to the adapter this will result in a use 
after free. To do this properly i2c_add_adapter() needs to be changed to 
i2c_alloc_adapter() that returns a pointer to a newly allocated adapter. 
i2c_free_adapter() will then only drop a reference to the adapter, but not free 
any memory. Once the last reference has been removed the memory can then be 
freed in the release callback.

The other issue is as long as something has a reference to the adapter they can 
run operations on the adapter. So freeing the adapter also has to make sure 
that any further operations that are performed on the adapter do no longer call 
into the device specific ops, but rather returns -ENODEV, or similar.

- Lars
