Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 10:57:36 +0200 (CEST)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42194 "EHLO
        www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491065Ab1FUI5b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jun 2011 10:57:31 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by www.etchedpixels.co.uk (8.14.4/8.14.4) with ESMTP id p5L8xqkN032421;
        Tue, 21 Jun 2011 09:59:52 +0100
Date:   Tue, 21 Jun 2011 09:59:51 +0100
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 11/13] serial: add driver for the built-in UART of the
 AR933X SoC
Message-ID: <20110621095951.7dc1c9ee@lxorguk.ukuu.org.uk>
In-Reply-To: <1308597973-6037-12-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
        <1308597973-6037-12-git-send-email-juhosg@openwrt.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEWysKsSBQMIAwIZCwj///8wIhxoRDXH9QHCAAABeUlEQVQ4jaXTvW7DIBAAYCQTzz2hdq+rdg494ZmBeE5KYHZjm/d/hJ6NfzBJpp5kRb5PHJwvMPMk2L9As5Y9AmYRBL+HAyJKeOU5aHRhsAAvORQ+UEgAvgddj/lwAXndw2laEDqA4x6KEBhjYRCg9tBFCOuJFxg2OKegbWjbsRTk8PPhKPD7HcRxB7cqhgBRp9Dcqs+B8v4CQvFdqeot3Kov6hBUn0AJitrzY+sgUuiA8i0r7+B3AfqKcN6t8M6HtqQ+AOoELCikgQSbgabKaJW3kn5lBs47JSGDhhLKDUh1UMipwwinMYPTBuIBjEclSaGZUk9hDlTb5sUTYN2SFFQuPe4Gox1X0FZOufjgBiV1Vls7b+GvK3SU4wfmcGo9rPPQzgIabfj4TYQo15k3bTHX9RIw/kniir5YbtJF4jkFG+dsDK1IgE413zAthU/vR2HVMmFUPIHTvF6jWCpFaGw/A3qWgnbxpSm9MSmY5b3pM1gvNc/gQfwBsGwF0VCtxZgAAAAASUVORK5CYII=
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 30470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16990

Looks good to me

Signed-off-by: Alan Cox <alan@linux.intel.com>

and no problem here with it going via the MIPS tree (but make sure GregKH
is happy)
