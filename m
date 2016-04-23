Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Apr 2016 13:57:50 +0200 (CEST)
Received: from www381.your-server.de ([78.46.137.84]:57556 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026868AbcDWL5rNetBN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Apr 2016 13:57:47 +0200
Received: from [88.198.220.131] (helo=sslproxy02.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1atwBx-0005wx-LE; Sat, 23 Apr 2016 13:57:41 +0200
Received: from [46.244.243.91] (helo=[192.168.178.38])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.84_2)
        (envelope-from <lars@metafoo.de>)
        id 1atwBx-0007AK-E4; Sat, 23 Apr 2016 13:57:41 +0200
Subject: Re: [PATCH 1/3] MIPS: JZ4740: Qi LB60: Remove support for AVT2
 variant
To:     Maarten ter Huurne <maarten@treewalker.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1461005933-24876-1-git-send-email-maarten@treewalker.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <571B6334.3070109@metafoo.de>
Date:   Sat, 23 Apr 2016 13:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
MIME-Version: 1.0
In-Reply-To: <1461005933-24876-1-git-send-email-maarten@treewalker.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.99/21503/Sat Apr 23 04:36:36 2016)
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53224
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

On 04/18/2016 08:58 PM, Maarten ter Huurne wrote:
> AVT2 was a prototype board of which about 5 were made, none of which
> are in use anymore.
> 
> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
