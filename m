Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 01:57:39 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:273 "HELO
	topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225241AbTFEA5g>; Thu, 5 Jun 2003 01:57:36 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 5 Jun 2003 00:57:34 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h550vKjf028992;
	Thu, 5 Jun 2003 09:57:20 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 05 Jun 2003 09:58:02 +0900 (JST)
Message-Id: <20030605.095802.59461340.nemoto@toshiba-tops.co.jp>
To: macro@ds2.pg.gda.pl
Cc: anemo@mba.ocn.ne.jp, linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: mips64 LOAD_KPTE2 fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.GSO.3.96.1030604160418.18707B-100000@delta.ds2.pg.gda.pl>
References: <20030604.100204.74756139.nemoto@toshiba-tops.co.jp>
	<Pine.GSO.3.96.1030604160418.18707B-100000@delta.ds2.pg.gda.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 4 Jun 2003 16:09:10 +0200 (MET DST), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
>> Thank you for pointing out this.  I did not think very much.  But
>> you mean "slt \tmp, \tmp, \ptr", don't you?

macro>  Not at all.  Why would I want to reverse the comparison?

Sorry, I garbled.  Please ignore my last patch.  Your patch works
fine.  Thank you again.

---
Atsushi Nemoto
