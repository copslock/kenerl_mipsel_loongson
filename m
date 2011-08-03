Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2011 17:07:22 +0200 (CEST)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54315 "EHLO
        www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S2100411Ab1HCPHQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Aug 2011 17:07:16 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by www.etchedpixels.co.uk (8.14.4/8.14.4) with ESMTP id p73FAT04026568;
        Wed, 3 Aug 2011 16:10:30 +0100
Date:   Wed, 3 Aug 2011 16:10:29 +0100
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
        greg@kroah.com
Subject: Re: [PATCH] SERIAL: Lantiq: Set timeout in uart_port
Message-ID: <20110803161029.1d46865f@lxorguk.ukuu.org.uk>
In-Reply-To: <20110803143724.GB8673@linux-mips.org>
References: <20110803143724.GB8673@linux-mips.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEWysKsSBQMIAwIZCwj///8wIhxoRDXH9QHCAAABeUlEQVQ4jaXTvW7DIBAAYCQTzz2hdq+rdg494ZmBeE5KYHZjm/d/hJ6NfzBJpp5kRb5PHJwvMPMk2L9As5Y9AmYRBL+HAyJKeOU5aHRhsAAvORQ+UEgAvgddj/lwAXndw2laEDqA4x6KEBhjYRCg9tBFCOuJFxg2OKegbWjbsRTk8PPhKPD7HcRxB7cqhgBRp9Dcqs+B8v4CQvFdqeot3Kov6hBUn0AJitrzY+sgUuiA8i0r7+B3AfqKcN6t8M6HtqQ+AOoELCikgQSbgabKaJW3kn5lBs47JSGDhhLKDUh1UMipwwinMYPTBuIBjEclSaGZUk9hDlTb5sUTYN2SFFQuPe4Gox1X0FZOufjgBiV1Vls7b+GvK3SU4wfmcGo9rPPQzgIabfj4TYQo15k3bTHX9RIw/kniir5YbtJF4jkFG+dsDK1IgE413zAthU/vR2HVMmFUPIHTvF6jWCpFaGw/A3qWgnbxpSm9MSmY5b3pM1gvNc/gQfwBsGwF0VCtxZgAAAAASUVORK5CYII=
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 30825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2427

On Wed, 3 Aug 2011 15:37:24 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> From: John Crispin <blogic@openwrt.org>
> 
> Without this patch apps using readline hang.
> 
> Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
> Signed-off-by: John Crispin <blogic@openwrt.org>

Signed-off-by: Alan Cox <alan@linux.intel.com>
