Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2015 02:04:39 +0100 (CET)
Received: from ozlabs.org ([103.22.144.67]:38217 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009768AbbA1BEiL6dql (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jan 2015 02:04:38 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id A3D2A140284;
        Wed, 28 Jan 2015 12:04:34 +1100 (AEDT)
Message-ID: <1422407074.32234.2.camel@ellerman.id.au>
Subject: Re: [PATCH 0/4] defconfigs: cleanup obsolete MTD configs
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     semen.protsenko@globallogic.com
Cc:     Paul Bolle <pebolle@tiscali.nl>, linux-mips@linux-mips.org,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-am33-list@redhat.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        linux-mtd@lists.infradead.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Haavard Skinnemoen <hskinnemoen@gmail.com>
Date:   Wed, 28 Jan 2015 12:04:34 +1100
In-Reply-To: <CAJOTznWHpRh8ysVxwSWyvZL1UAe-G9A64j=M6z0+zPeoycgkDg@mail.gmail.com>
References: <1422117213-3130-1-git-send-email-semen.protsenko@globallogic.com>
         <1422118156.27947.7.camel@x220>
         <CAJOTznWHpRh8ysVxwSWyvZL1UAe-G9A64j=M6z0+zPeoycgkDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

On Sat, 2015-01-24 at 22:54 +0200, Sam Protsenko wrote:
> > That's news for me. I thought they are silently ignored. Do you have an
> > example of such a warning?
> 
> Not really. It was just assumption. It seems you are right, they are just
> ignored silently. But item 2 is still relevant and it was actually confused
> me when I tried to figure out MTD configuration for my platform.
> Anyway, garbage should be taken out from time to time.

The usual way that this gets dealt with is that arch maintainers (ir)regularly
run make savedefconfig on all their defconfigs.

As it happens we've done that on powerpc just recently, if you rebase onto next
you should see that, so you can drop the powerpc hunks from your patches. 

cheers
