Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Nov 2012 16:49:39 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:58357 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824810Ab2KRPtiawRN5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 18 Nov 2012 16:49:38 +0100
Message-ID: <50A9034E.4050306@phrozen.org>
Date:   Sun, 18 Nov 2012 16:48:30 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH v4 0/3] MIPS: BCM47xx: use gpiolib
References: <1347376511-20953-1-git-send-email-hauke@hauke-m.de> <CACna6rw0Qy2=zo6wHcq20JBM8OJb-wnZJGLH3dksaLGFoyp+=w@mail.gmail.com> <50A8D8C9.1000802@hauke-m.de>
In-Reply-To: <50A8D8C9.1000802@hauke-m.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 18/11/12 13:47, Hauke Mehrtens wrote:
> On 11/18/2012 12:05 PM, Rafał Miłecki wrote:
>> 2012/9/11 Hauke Mehrtens<hauke@hauke-m.de>:
>>> The original code implemented the GPIO interface itself and this caused
>>> some problems. With this patch gpiolib is used.
>>>
>>> This is based on mips/master.
>>>
>>> This should go through linux-mips, John W. Linville approved that
>>> for the bcma and ssb changes normally maintained in wireless-testing.
>>
>> Ping? Did it go upstream? I can't find that commits in
>> http://git.kernel.org/?p=linux/kernel/git/ralf/linux.git;a=summary
>>
> I talked to John Crispin in IRC, he does not like this patch and I will
> send a new version today.
>
> Hauke
>
>

Hi,

Without looking into the details of the code we agreed, that there was a 
better solution to the ifdeferey embedded inside switch constructs, that 
had no break statement.

	John
