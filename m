Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 19:49:07 +0200 (CEST)
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60115 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903681Ab2ENRtB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2012 19:49:01 +0200
Received: from pyramind.ukuu.org.uk (earthlight.etchedpixels.co.uk [81.2.110.250])
        by lxorguk.ukuu.org.uk (8.14.5/8.14.1) with ESMTP id q4EIIx8P025547;
        Mon, 14 May 2012 19:19:04 +0100
Received: from pyramind.ukuu.org.uk (localhost [127.0.0.1])
        by pyramind.ukuu.org.uk (8.14.5/8.14.5) with ESMTP id q4EHptS3022485;
        Mon, 14 May 2012 18:51:56 +0100
Date:   Mon, 14 May 2012 18:51:55 +0100
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
Subject: Re: [RESEND PATCH V2 10/17] SERIAL: MIPS: lantiq: implement OF
 support
Message-ID: <20120514185155.284bd51c@pyramind.ukuu.org.uk>
In-Reply-To: <1337017363-14424-10-git-send-email-blogic@openwrt.org>
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
        <1337017363-14424-10-git-send-email-blogic@openwrt.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-redhat-linux-gnu)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEWysKsSBQMIAwIZCwj///8wIhxoRDXH9QHCAAABeUlEQVQ4jaXTvW7DIBAAYCQTzz2hdq+rdg494ZmBeE5KYHZjm/d/hJ6NfzBJpp5kRb5PHJwvMPMk2L9As5Y9AmYRBL+HAyJKeOU5aHRhsAAvORQ+UEgAvgddj/lwAXndw2laEDqA4x6KEBhjYRCg9tBFCOuJFxg2OKegbWjbsRTk8PPhKPD7HcRxB7cqhgBRp9Dcqs+B8v4CQvFdqeot3Kov6hBUn0AJitrzY+sgUuiA8i0r7+B3AfqKcN6t8M6HtqQ+AOoELCikgQSbgabKaJW3kn5lBs47JSGDhhLKDUh1UMipwwinMYPTBuIBjEclSaGZUk9hDlTb5sUTYN2SFFQuPe4Gox1X0FZOufjgBiV1Vls7b+GvK3SU4wfmcGo9rPPQzgIabfj4TYQo15k3bTHX9RIw/kniir5YbtJF4jkFG+dsDK1IgE413zAthU/vR2HVMmFUPIHTvF6jWCpFaGw/A3qWgnbxpSm9MSmY5b3pM1gvNc/gQfwBsGwF0VCtxZgAAAAASUVORK5CYII=
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 33301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, 14 May 2012 19:42:36 +0200
John Crispin <blogic@openwrt.org> wrote:

> Add devicetree and handling for our new clkdev clocks. The patch is rather
> straightforward. .of_match_table is set and the 3 irqs are now loaded from the
> devicetree.
> 
> This series converts the lantiq target to clkdev amongst other things. The
> driver needs to handle two clocks now. The fpi bus clock used to derive the
> divider and the clock gate needed on some socs to make the secondary port work.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: linux-serial@vger.kernel.org

Doesn't really touch the tty parts of the logic so fine by me
