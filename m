Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2012 22:51:53 +0200 (CEST)
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52708 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903748Ab2GTUvt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2012 22:51:49 +0200
Received: from pyramind.ukuu.org.uk (earthlight.etchedpixels.co.uk [81.2.110.250])
        by lxorguk.ukuu.org.uk (8.14.5/8.14.1) with ESMTP id q6KLOqZt015797;
        Fri, 20 Jul 2012 22:24:57 +0100
Received: from pyramind.ukuu.org.uk (localhost [127.0.0.1])
        by pyramind.ukuu.org.uk (8.14.5/8.14.5) with ESMTP id q6KKtHRs012699;
        Fri, 20 Jul 2012 21:55:17 +0100
Date:   Fri, 20 Jul 2012 21:55:16 +0100
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Daney <david.daney@cavium.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: linux-next: build failure after merge of the tty tree
Message-ID: <20120720215516.03abd164@pyramind.ukuu.org.uk>
In-Reply-To: <CAMuHMdWRM0y07r1nL-9fXB3nLKXMgftqhiruEeuEe4QYDA2o9Q@mail.gmail.com>
References: <20120713141345.f71b7c01f720d616d74721dd@canb.auug.org.au>
        <20120713121053.0637219f@pyramind.ukuu.org.uk>
        <CAMuHMdWRM0y07r1nL-9fXB3nLKXMgftqhiruEeuEe4QYDA2o9Q@mail.gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-redhat-linux-gnu)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEWysKsSBQMIAwIZCwj///8wIhxoRDXH9QHCAAABeUlEQVQ4jaXTvW7DIBAAYCQTzz2hdq+rdg494ZmBeE5KYHZjm/d/hJ6NfzBJpp5kRb5PHJwvMPMk2L9As5Y9AmYRBL+HAyJKeOU5aHRhsAAvORQ+UEgAvgddj/lwAXndw2laEDqA4x6KEBhjYRCg9tBFCOuJFxg2OKegbWjbsRTk8PPhKPD7HcRxB7cqhgBRp9Dcqs+B8v4CQvFdqeot3Kov6hBUn0AJitrzY+sgUuiA8i0r7+B3AfqKcN6t8M6HtqQ+AOoELCikgQSbgabKaJW3kn5lBs47JSGDhhLKDUh1UMipwwinMYPTBuIBjEclSaGZUk9hDlTb5sUTYN2SFFQuPe4Gox1X0FZOufjgBiV1Vls7b+GvK3SU4wfmcGo9rPPQzgIabfj4TYQo15k3bTHX9RIw/kniir5YbtJF4jkFG+dsDK1IgE413zAthU/vR2HVMmFUPIHTvF6jWCpFaGw/A3qWgnbxpSm9MSmY5b3pM1gvNc/gQfwBsGwF0VCtxZgAAAAASUVORK5CYII=
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 33947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
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

> Today's build failed because there's a new user in the MIPS tree:
> arch/mips/cavium-octeon/serial.c
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/6739341/

The version in the tree I have registers a platform device rather than
calling into 8250 directly. That appears to be rather better mannered
than whatever you are building.

If someone has moved from the platform device could they kindly explain
*why* ?
