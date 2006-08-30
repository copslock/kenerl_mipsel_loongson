Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2006 13:12:37 +0100 (BST)
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:36112 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S20037642AbWH3MMg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Aug 2006 13:12:36 +0100
Received: from flint.arm.linux.org.uk ([2002:d993:5cf9:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1GIOvb-00031k-6k; Wed, 30 Aug 2006 13:12:19 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1GIOvZ-0006mO-CH; Wed, 30 Aug 2006 13:12:17 +0100
Date:	Wed, 30 Aug 2006 13:12:17 +0100
From:	Russell King <rmk@arm.linux.org.uk>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-serial@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org,
	Thomas K?ller <thomas@koeller.dyndns.org>
Subject: Re: [PATCH] RM9000 serial driver
Message-ID: <20060830121216.GA25699@flint.arm.linux.org.uk>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608260038.13662.thomas.koeller@baslerweb.com> <44F441F3.8050301@ru.mvista.com> <200608300100.32836.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608300100.32836.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Wed, Aug 30, 2006 at 01:00:32AM +0200, Thomas Koeller wrote:
> I would like to return to the port type vs. iotype  stuff once again.
> From what you wrote I seem to understand that the iotype is not just
> a method of accessing device registers, but also the primary means of
> discrimination between different h/w implementations, and hence every
> code to support a nonstandard device must define an iotype of its own,
> even though one of the existing iotypes would work just fine?

iotype is all about the access method used to access the registers of
the device, be it by byte or word, and it also takes account of any
variance in the addressing of the registers.

It does not refer to features or bugs in any particular implementation.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
