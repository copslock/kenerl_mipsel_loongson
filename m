Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2012 09:37:34 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36414 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822164Ab2KIIhddGuVI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Nov 2012 09:37:33 +0100
Message-ID: <509CC092.8090609@phrozen.org>
Date:   Fri, 09 Nov 2012 09:36:34 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     Takashi Iwai <tiwai@suse.de>
CC:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org, Zhangjin Wu <wuzhangjin@gmail.com>,
        Hua Yan <yanh@lemote.com>, Fuxin Zhang <zhangfx@lemote.com>,
        linux-kernel@vger.kernel.org, Hongliang Tao <taohl@lemote.com>,
        Jie Chen <chenj@lemote.com>
Subject: Re: [alsa-devel] [PATCH V6 12/15] ALSA: HDA: Make hda sound card
 usable        for Loongson
References: <1345193015-3024-1-git-send-email-chenhc@lemote.com>        <1345193015-3024-13-git-send-email-chenhc@lemote.com> <s5hy5ldvq9e.wl%tiwai@suse.de>
In-Reply-To: <s5hy5ldvq9e.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34919
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

On 17/08/12 11:09, Takashi Iwai wrote:
> At Fri, 17 Aug 2012 16:43:32 +0800,
> Huacai Chen wrote:
>> >
>> >  Lemote A1004(Laptop) and A1205(All-In-One) use Conexant's hda codec,
>> >  this patch modify patch_conexant.c to add Lemote specific code.
>> >
>> >  Both A1004 and A1205 use the same pin configurations, but A1004 need
>> >  to increase the default boost of internal mic.
>> >
>> >  Signed-off-by: Jie Chen<chenj@lemote.com>
>> >  Signed-off-by: Huacai Chen<chenhc@lemote.com>
>> >  Signed-off-by: Hongliang Tao<taohl@lemote.com>
>> >  Signed-off-by: Hua Yan<yanh@lemote.com>
>> >  Cc:alsa-devel@alsa-project.org
> Looks good.
> 	Reviewed-by: Takashi Iwai<tiwai@suse.de>
>
> Should I apply it to sound git tree or all patches will go through
> mips tree?
>
>
> thanks,
>
> Takashi
>


Hi Takashi,

did you take this patch ? I will queue several of the other patches from 
the series for 3.8 and let them go upstream via the mips tree. We have 
this patch open in the linux-mips patchwork. I would set it to "Other 
Subsystem" if you took it already.

Thanks,
	John
