Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Oct 2013 18:08:29 +0200 (CEST)
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:52398 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6823127Ab3JLQI1Cpt1G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Oct 2013 18:08:27 +0200
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2C35F235AE;
        Sat, 12 Oct 2013 16:08:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: list93_e60e4ee8c209
X-Filterd-Recvd-Size: 2897
Received: from [192.168.1.157] (pool-96-251-49-11.lsanca.fios.verizon.net [96.251.49.11])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Oct 2013 16:08:18 +0000 (UTC)
Message-ID: <1381594098.8864.9.camel@joe-AO722>
Subject: Re: [PATCH 2/2] framebuffer: Remove pmag-aa-fb
From:   Joe Perches <joe@perches.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Date:   Sat, 12 Oct 2013 09:08:18 -0700
In-Reply-To: <alpine.LFD.2.03.1310121308310.10951@linux-mips.org>
References: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com>
         <6f500d88eb23fd9a4cfc5583f5ca17bc5f58fe24.1379641901.git.joe@perches.com>
         <CAMuHMdW6R5qTJ0uvsUUaYBZAqFcNshPsXeMbz5hwqq5UOkJr-g@mail.gmail.com>
         <alpine.LFD.2.03.1309201907380.8379@linux-mips.org>
         <1379702587.2301.12.camel@joe-AO722>
         <alpine.LFD.2.03.1309201946430.8379@linux-mips.org>
         <alpine.LFD.2.03.1310121308310.10951@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Sat, 2013-10-12 at 14:08 +0100, Maciej W. Rozycki wrote:
[]
> So I think I've got all the basic stuff covered now, including a change 
> similar to your proposal as well as a conversion to the driver model/new 
> TURBOchannel support infrastructure.  But what I remembered is actually 
> right, the issue is wiring hardware cursor support into fbcon.  The driver 
> uses its own display_switch structure with its own aafbcon_cursor handler 
> to use the twin onboard Bt431 chips for cursor generation (there's also 
> aafbcon_set_font that pokes at the Bt431s for cursor dimension changes).  
> I need to figure out what the best way will be to make the fbcon subsystem 
> support such an arrangement and that'll take me a little bit yet, so 
> please be patient.
> 
> Note that the board is weird enough to have a 1-bit (true monochrome) 
> graphics plane, however the Bt455 used by the MX graphics adapter for 
> screen image generation is a 4-bit grey-scale video RAMDAC (only the LSB 
> inputs of its pixel port are wired to the graphics plane) and the twin 
> Bt431s use the overlay plane to produce a 2-bit grey-scale cursor.  So we 
> do want to use the hardware cursor to be able to make it prominent among 
> the characters displayed throughout the screen and a software-generated 
> cursor cannot really substitute what hardware provides.

I hope you're enjoying tinkering with old toys.

Best of luck getting it going.
