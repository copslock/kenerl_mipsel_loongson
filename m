Received:  by oss.sgi.com id <S305157AbPLCNKi>;
	Fri, 3 Dec 1999 05:10:38 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:50250 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbPLCNKW>;
	Fri, 3 Dec 1999 05:10:22 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id FAA22340; Fri, 3 Dec 1999 05:13:10 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA50308
	for linux-list;
	Fri, 3 Dec 1999 05:01:11 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA88909
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 3 Dec 1999 05:01:10 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA03739
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Dec 1999 05:01:04 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPLCM5F>;
	Fri, 3 Dec 1999 10:57:05 -0200
Date:   Fri, 3 Dec 1999 10:57:05 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Jakma, Paul" <Paul.Jakma@compaq.com>
Cc:     "'linux@engr.sgi.com'" <linux@cthulhu.engr.sgi.com>
Subject: Re: Indy ISDN on linux?
Message-ID: <19991203105705.D982@uni-koblenz.de>
References: <15AD5D7936F8D21198240000F831776E3E7F70@dboexc1.dbo.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <15AD5D7936F8D21198240000F831776E3E7F70@dboexc1.dbo.cpqcorp.net>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Dec 02, 1999 at 03:06:26PM -0000, Jakma, Paul wrote:

> I was wondering if the onboard Indy ISDN is supported by linux? I'm
> considering turning my indy into a linux dial-up isdn, masq, firewall box.
> 
> If not supported is anyone considering working on it? and what kind of
> hardware is it? (Doc's/references/pointers appreciated)

Thomas Bogendörfer has implemented the full ISDN support for the IP22.  The
bad news is that his job keeps him to busy to add some finishing touches
and contribute the code back.

  Ralf
