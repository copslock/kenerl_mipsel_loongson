Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 15:54:44 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12218 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038999AbXBPPym (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Feb 2007 15:54:42 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1GFsgrL026896;
	Fri, 16 Feb 2007 15:54:42 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1GFsg9k026895;
	Fri, 16 Feb 2007 15:54:42 GMT
Date:	Fri, 16 Feb 2007 15:54:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Fix __copy_{to,from}_user_inatomic
Message-ID: <20070216155441.GA26835@linux-mips.org>
References: <45D5CEA5.3050604@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45D5CEA5.3050604@innova-card.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 16, 2007 at 04:32:53PM +0100, Franck Bui-Huu wrote:

> These functions are aliases to __copy_{to,from}_user resp but they
> are not allowed to sleep. Therefore might_sleep() must not be used
> by their implementions.

The _inatomic functions are know to buggy but this doesn't quite fix the
whole issues with them.  On error __copy_from_user_inatomic should not
clear the non-copied part of the destination buffer.  See
01408c4939479ec46c15aa7ef6e2406be50eeeca and
7c12d81134b130ccd4c286b434ca48c4cda71a2f for the rationale.

  Ralf
