Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 14:39:12 +0100 (CET)
Received: from mout.web.de ([212.227.17.12]:60609 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990436AbdLKNjEwmgvE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Dec 2017 14:39:04 +0100
Received: from [192.168.1.3] ([92.227.98.61]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LiCop-1espMD2NMJ-00nQ4h; Mon, 11
 Dec 2017 14:38:54 +0100
Subject: Re: [PATCH] TC: Delete an error message for a failed memory
 allocation in tc_bus_add_devices()
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Cc:     Joe Perches <joe@perches.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <bfb63956-346c-aa17-5b06-fbe19ff0a5e3@users.sourceforge.net>
 <alpine.LFD.2.21.1712102140570.4266@eddie.linux-mips.org>
 <1512957931.26342.31.camel@perches.com>
 <alpine.LFD.2.21.1712110244450.4266@eddie.linux-mips.org>
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <b553c094-238a-663b-a374-a7075feb9f4b@users.sourceforge.net>
Date:   Mon, 11 Dec 2017 14:38:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1712110244450.4266@eddie.linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:WMtSxJArtHTaohMH7ryrdFjuXVnhJYsKQZIlDAaj/+Fb5nXpGyV
 ejcSy1TZDfmKfp/zsO3V9RVwnTeKFlHI2FtA6p++FDa2fK9IdyY7fzGtYtoXQ0YCCIjAL5+
 NBi8lLILBlfwasz7Pg5K0i6hhQVeUhozxh0vdmMkz2ZDo+k/wEqR5BeE+0FeFBgxuONwP+J
 6rSb++3ejfgxZzDjZuIiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dtfiYFlok+g=:s4efMMd7vxKdCPNCDMct9A
 JEncqgCW9gecvVoztdi/gzKP7ttfSZ6O65Se9gJs1q0mB4He55wn0Ye3M8Abk65JLThyk7O2p
 Cl5RY9xpo7apRfoB6doQ2xvCmR53ZQ3Tlggf+rU2PM8fBj5RDhbqRnKOKZrEgUojBEkOGuxZk
 MgNr/xcETffqqGb4kCLoE1n3IPoJjF1Wt5lRY7CoeYvyxNiVcNLMet6yVg9uzAHKtDdBMGcT1
 rz/QzlctDgEbtDHrT8I8/yDGQ0fjVDtIES10U0QR3VY+uRHlclQDMNq5QTKP+n7n7jN0UmrDM
 UZRQBHJPN8RWEhZ1Pj4E6/PAlmZH/LpwnZaT6SaZl4ghLzzSe1WjcSxuKtYt+H8xxSyEbJjxR
 BqhShg/2/2u2YD7lL397YYK/O6r3Zc2Jl0ke6704Q0xYMFr2E56QmQDorPBhmWeX1BSgPFpN2
 I0hSJQ7NIEDC2JPzbvXVJGILjA+Cg7sH2pO6SyeFET22WAxGBqs/nQcYGlU0bAk6eu20UCR1A
 qcs0Q7SiWnZ1XLl8hjpHrxEhMtaKAKu6gkuX2oX+PasTK2cBtIvt2BUecXwqPqVTk7Z6UrsyG
 nB5zPlBlA6j9ivJNvoalSdvIuIePU9PD/p0xJJXDDn7JYjKoZYSH2TaQx9agX8dT7mP5GIGeQ
 mDBze/xIJJQfln7J83zqi3LnQ8taQRTimJrFtsthbDBTrv2M/wkgzcQs5TNiuFMSuv+zvCQlE
 6Cl41m/btG6uR4ATGVa11ZaMNsksgTptqrmhg+dwVtisfsO53C91ugp7wa4EH7Tr4Wu0YET8o
 x33N9bHDsppYO3XpJjrRZqkTefXolDC+SdckC3op5Lgy/6NXf0=
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

>  However I would indeed prefer that a commit description is at least 
> exhaustive enough for such a dumb reviewer as I am to understand what is 
> going on right away.

I can follow your desire in principle.


> So please make it say at least:
> 
> "Remove an extraneous message that duplicates the diagnostic already 
> provided by `kzalloc' for a memory allocation failure in this function."

How much clarification can such a wording bring to the software situation
if the desired data structures might be still unclear for “the diagnostic”?


> or suchlike in v2 for me to apply a Reviewed-by: tag.

Are you interested in a safe description for a default Linux allocation
failure report?

How do you think about corresponding reference documentation
(besides source code)?

Regards,
Markus
