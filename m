Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:28:14 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50374 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903645Ab2HUS2K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Aug 2012 20:28:10 +0200
Message-ID: <5033D2E9.1080804@phrozen.org>
Date:   Tue, 21 Aug 2012 20:26:49 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH resend] ifdef gic_present variable that is used only by
 malta
References: <1291221075.31413.24.camel@paanoop1-desktop>         <20110125132132.GA25526@linux-mips.org> <1295963846.27661.548.camel@paanoop1-desktop>
In-Reply-To: <1295963846.27661.548.camel@paanoop1-desktop>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 34312
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

On 25/01/11 14:57, Anoop P A wrote:
> VSMP kernel build for non-malta platforms fails with following error
> 
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/mips/built-in.o: In function `vsmp_init_secondary':
> smp-mt.c:(.cpuinit.text+0x23cc): undefined reference to `gic_present'
> smp-mt.c:(.cpuinit.text+0x23d0): undefined reference to `gic_present'
> make: *** [.tmp_vmlinux1] Error 1
> 
> gic_present variable is declared only if IRQ_GIC is selected.
> 
> Signed-off-by: Anoop P A <anoop.pa@gmail.com>


Thanks, queued for 3.7. (with a slightly different Subject)

	John
