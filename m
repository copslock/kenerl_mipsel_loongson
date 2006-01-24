Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 09:44:37 +0000 (GMT)
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:8860 "EHLO
	gw01.mail.saunalahti.fi") by ftp.linux-mips.org with ESMTP
	id S8133406AbWAXJoT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 09:44:19 +0000
Received: from tori.tal.org (tori.tal.org [195.16.220.82])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id C1E3311269E;
	Tue, 24 Jan 2006 11:48:31 +0200 (EET)
Date:	Tue, 24 Jan 2006 11:50:04 +0200 (EET)
From:	Kaj-Michael Lang <milang@tal.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
In-Reply-To: <20060123225040.GA23576@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.61.0601241147170.19397@tori.tal.org>
References: <20060123225040.GA23576@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

On Mon, 23 Jan 2006, Martin Michlmayr wrote:

> We're getting the following boot error on a DECstation with R3K CPU.
> It simply hangs after the "high precision timer" message.  Maciej, do

It's trying to use a timer source that does not exist on the DECstation 
you're trying to use, most likely. What model is it you have ? I've 
tracked it down when I got my first (working) DECstation (5000/133) a
month or so ago. Forgot all about it under the holidays. I think
I have a patch somewhere to fix it, I'll do some digging.

-- 
Kaj-Michael Lang
