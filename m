Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 15:28:17 +0100 (BST)
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:29310 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8134010AbWFGO2J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Jun 2006 15:28:09 +0100
Received: (qmail 16499 invoked from network); 7 Jun 2006 14:27:59 -0000
Received: from unknown (HELO ascent-enet) (david-b@pacbell.net@69.226.238.181 with plain)
  by smtp106.sbc.mail.mud.yahoo.com with SMTP; 7 Jun 2006 14:27:58 -0000
From:	David Brownell <david-b@pacbell.net>
To:	linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] Fix OHCI HCD build for PNX 8550
Date:	Wed, 7 Jun 2006 07:27:56 -0700
User-Agent: KMail/1.7.1
Cc:	Ralf Baechle <ralf@linux-mips.org>, gregkh@suse.de,
	linux-mips@linux-mips.org
References: <20060607135922.GA26754@linux-mips.org>
In-Reply-To: <20060607135922.GA26754@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606070727.57618.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Wednesday 07 June 2006 6:59 am, Ralf Baechle wrote:
> The PNX8550 OHCI is a platform device so we better include the necessary
> headers.

PNX ohci support has not been submitted upstream yet... just merge this
with that patch before submitting.
