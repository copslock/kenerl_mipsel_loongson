Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 06:41:22 +0200 (CEST)
Received: from mail.active-venture.com ([67.228.131.205]:64819 "EHLO
        mail.active-venture.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821654AbaFRElULpHyY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2014 06:41:20 +0200
Received: (qmail 24888 invoked by uid 399); 18 Jun 2014 04:41:11 -0000
Received: from unknown (HELO server.roeck-us.net) (linux@roeck-us.net@108.223.40.66)
  by mail.active-venture.com with ESMTPAM; 18 Jun 2014 04:41:11 -0000
X-Originating-IP: 108.223.40.66
X-Sender: linux@roeck-us.net
Message-ID: <53A1185E.6080707@roeck-us.net>
Date:   Tue, 17 Jun 2014 21:41:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.16-rc1
References: <1403018163-25307-1-git-send-email-geert@linux-m68k.org> <CAMuHMdU2DTt0va67uSKqhhqbVORuY+xEs3uGZ21sKjahE_MSXg@mail.gmail.com>
In-Reply-To: <CAMuHMdU2DTt0va67uSKqhhqbVORuY+xEs3uGZ21sKjahE_MSXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 06/17/2014 08:23 AM, Geert Uytterhoeven wrote:
> On Tue, Jun 17, 2014 at 5:16 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
[...]
>
>>    + /scratch/kisskb/src/sound/soc/fsl/fsl_dma.c: error: invalid use of undefined type 'struct ccsr_ssi':  => 926:34, 927:34
>
> powerpc/mpc85xx_defconfig
>

Being fixed:
	http://patchwork.ozlabs.org/patch/358500/

Guenter
