Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2006 21:30:44 +0100 (BST)
Received: from mail01.hansenet.de ([213.191.73.61]:38615 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20037611AbWHQUan (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 Aug 2006 21:30:43 +0100
Received: from [213.39.182.221] (213.39.182.221) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44DC9FF70017F943; Thu, 17 Aug 2006 22:30:31 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 0E1501770BE;
	Thu, 17 Aug 2006 22:30:31 +0200 (CEST)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
To:	Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Image capturing driver for Basler eXcite smart camera
Date:	Thu, 17 Aug 2006 22:30:30 +0200
User-Agent: KMail/1.9.3
Cc:	=?iso-8859-1?q?=C9ric_Piel?= <Eric.Piel@lifl.fr>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	linux-mips@linux-mips.org
References: <200608102318.04512.thomas.koeller@baslerweb.com> <200608142126.29171.thomas.koeller@baslerweb.com> <20060817153138.GE5950@ucw.cz>
In-Reply-To: <20060817153138.GE5950@ucw.cz>
Organization: Basler AG
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608172230.30682.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Thursday 17 August 2006 17:31, Pavel Machek wrote:
> Well, I guess v4l api will need to be improved, then. That is still
> not a reason to introduce completely new api...

The API as implemented by the driver I submitted is very minimalistic,
because it is just a starting point. There's more to be added in future,
like controlling flashes, interfacing to line-scan cameras clocked by
incremental encodes attached to some conveyor, and other stuff which
is common in industrial image processing applications. You really do
not want to clutter the v4l2 API with these things; that would hardly
be an 'improvement'.

Different interfaces, designed to serve different purposes...

Thomas
-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
