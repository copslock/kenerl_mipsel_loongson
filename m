Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2005 14:12:40 +0000 (GMT)
Received: from sorrow.cyrius.com ([IPv6:::ffff:65.19.161.204]:783 "EHLO
	sorrow.cyrius.com") by linux-mips.org with ESMTP
	id <S8225750AbVCROMZ>; Fri, 18 Mar 2005 14:12:25 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id D931664D40; Fri, 18 Mar 2005 14:12:22 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id A3EBF4F29C; Fri, 18 Mar 2005 14:12:08 +0000 (GMT)
Date:	Fri, 18 Mar 2005 14:12:08 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Stuart Longland <stuartl@longlandclan.hopto.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Netbooting CoLo on the Cobalt RaQ1
Message-ID: <20050318141208.GA26486@deprecation.cyrius.com>
References: <423AD5A2.3060200@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423AD5A2.3060200@longlandclan.hopto.org>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Stuart Longland <stuartl@longlandclan.hopto.org> [2005-03-18 23:20]:
> 	It appears the RaQ1 is a special case, and does not look there to
> download its kernel.  Does anyone know exactly where these boxes look
> for the kernel image when netbooting?  That way, I can ammend[1] the
> handbook with the new details.

Possibly vmlinux_RAQ.gz.  In Debian, we have a file called vmlinux.gz
and the symlinks vmlinux_raq-2800.gz and vmlinux_RAQ.gz pointing to
it, and that seems to work for everyone.
-- 
Martin Michlmayr
http://www.cyrius.com/
