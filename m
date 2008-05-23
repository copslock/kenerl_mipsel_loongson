Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2008 03:36:36 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:8089 "EHLO
	vigor.karmaclothing.net.") by ftp.linux-mips.org with ESMTP
	id S20032933AbYEWCgd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 May 2008 03:36:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net. (8.14.1/8.14.1) with ESMTP id m4N2aQZE025028;
	Fri, 23 May 2008 03:36:28 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4N2aNmM025009;
	Fri, 23 May 2008 03:36:23 +0100
Date:	Fri, 23 May 2008 03:36:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Linux MIPS Org <linux-mips@linux-mips.org>
Subject: Re: Patch to add M3Pnet Driver
Message-ID: <20080523023623.GA17651@linux-mips.org>
References: <4835F799.6070302@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4835F799.6070302@mips.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 23, 2008 at 12:45:45AM +0200, Kevin D. Kissell wrote:
> From: "Kevin D. Kissell" <kevink@mips.com>
> Date: Fri, 23 May 2008 00:45:45 +0200
> To: Linux MIPS Org <linux-mips@linux-mips.org>
> Subject: Patch to add M3Pnet Driver
> Content-Type: multipart/mixed;
> 	boundary="------------050707080700070300010401"
> 
> As per previous messages, here's 2 of 2

This is largely a network driver patch with minor arch bits thrown in so
this one will have to go via jeff@garzik.org and netdev@vger.kernel.org.
The MIPS bits are looking good though so feel free to add my

Acked-by: Ralf Baechle <ralf@linux-mips.org>

line for them.

  Ralf
