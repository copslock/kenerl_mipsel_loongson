Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 09:57:09 +0200 (CEST)
Received: from darkcity.gna.ch ([195.226.6.51]:55813 "EHLO mail.gna.ch"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903552Ab2FSH5C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 09:57:02 +0200
Received: from localhost (localhost [127.0.0.1])
        by darkcity.gna.ch (Postfix) with ESMTP id BBDA714E072;
        Tue, 19 Jun 2012 10:03:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at gna.ch
Received: from mail.gna.ch ([127.0.0.1])
        by localhost (darkcity.gna.ch [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R9GAd-Ae9oUz; Tue, 19 Jun 2012 10:03:29 +0200 (CEST)
Received: from thor (77-56-77-139.dclient.hispeed.ch [77.56.77.139])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by darkcity.gna.ch (Postfix) with ESMTPSA id 79CD214E06A;
        Tue, 19 Jun 2012 10:03:25 +0200 (CEST)
Received: from daenzer by thor with local (Exim 4.80)
        (envelope-from <michel@daenzer.net>)
        id 1SgtIs-0001at-8A; Tue, 19 Jun 2012 09:56:46 +0200
Message-ID: <1340092605.5442.0.camel@thor.local>
Subject: Re: [PATCH V2 12/16] drm/radeon: Make radeon card usable for
 Loongson.
From:   Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        dri-devel@lists.freedesktop.org, Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Date:   Tue, 19 Jun 2012 09:56:45 +0200
In-Reply-To: <1340088624-25550-13-git-send-email-chenhc@lemote.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
         <1340088624-25550-13-git-send-email-chenhc@lemote.com>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAADBQTFRFDg4OHh4eLCwsOzs7S0tLWlpaa2treXl5hISEjY2NmJiYqKiotLS0xsbG1dXV/Pz81CO0SQAAArtJREFUOMtd1M9P01AcAHCI/4AtGq/QDfDHRfraEX8eaNeJFw1rO/DCYet7mxc1ZG0x3sStHQkmZpqtHDwAi+tMiFEzbZdwNWEJR48cjPG4g5HhELUbrHvjpYe2n7zvt++977cD/7rjsCry8uNG93Gge9OKUyAAgLB1AlpTZICmAzR15QTEiQAPAKADYLMPfhNnEJR4HvD0tT5YI2KGUcyqihQN7mDwZ3hMN4q2N4ol+gEGTSLWhorrjYXrGPwc0jTDOoKP4xi8G0W6adl2Gz6zGDwag5p5PMON7vZgJuSB976+3U6y2QdeKNet1+uum9/qwVQHvEjtKesY0EIb7CNYe+7DIRXCID/vQ4tksVAY7JFBD7yvqrWTL93xoUmOQsPIddbnuk8v+bBPsigB2KRlFxS4nL/owwEpKBSg2MU3UcDf+nATyyHEQwrHzJZFNpXeuOHDC0qW4sMhEHESFGOUrvgQpWUYFVNQdjQxca8abnSB55CmehdcLSxa1ifoQ4JBpmGYWbhsly3X0fxQ7xmkW3Y5CztLcXI+fAu2oWho3nbV6s5rH35xSC/aBR2tOpVa/Utv25tcTDPL6aT21kG17WrvaFtMBJmFhJCsVF4uu9VG76DWBaRnEiNs7pU659pYlfwtQSRy9GCYlwR7C6/dPQgBw3MsTPNWA4d9SeMDDC9JYdnqq/amdF+diGnVhXFztQ/2lJSWjulOxjRX+uC7EkOqhLRk2ejrqHVBEqCqJLO5cmEXgx8TrBiWVQh1u2DhzQlPsyIveU2YLGorGBxODoR5notlpcUieoLB1/NEmGc4AalGJpLe8WF/8txMWASAkVVViQjzP
 jycPrvgA
        R1goSzOnkp14YCYHsp7QJHAS5QcXDqG1jBxdSITVgBNkBTFloj88Q/gMkFcuItYiQPUCBGc2xh5drsD/wGZrgsgDOE4ZAAAAABJRU5ErkJggg==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.4.2-2.0 
Mime-Version: 1.0
X-archive-position: 33708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michel@daenzer.net
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

On Die, 2012-06-19 at 14:50 +0800, Huacai Chen wrote: 
> 1, Use 32-bit DMA as a workaround (Loongson has a hardware bug that it
>    doesn't support DMA address above 4GB).
> 2, Read vga bios offered by system firmware.
> 3, Handle io prot correctly for MIPS.
> 4, Don't use swiotlb on Loongson machines (when use swiotlb, GPU reset
>    occurs at resume from suspend).

Sounds like this should be split up into smaller patches.


> diff --git a/include/drm/drm_sarea.h b/include/drm/drm_sarea.h
> index ee5389d..1d1a858 100644
> --- a/include/drm/drm_sarea.h
> +++ b/include/drm/drm_sarea.h
> @@ -37,6 +37,8 @@
>  /* SAREA area needs to be at least a page */
>  #if defined(__alpha__)
>  #define SAREA_MAX                       0x2000U
> +#elif defined(__mips__)
> +#define SAREA_MAX                       0x4000U
>  #elif defined(__ia64__)
>  #define SAREA_MAX                       0x10000U	/* 64kB */
>  #else

Also, this change doesn't seem to be accounted for in the commit log.


-- 
Earthling Michel Dänzer           |                   http://www.amd.com
Libre software enthusiast         |          Debian, X and DRI developer
