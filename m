Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2003 10:06:12 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:43410 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225388AbTJHJGE>; Wed, 8 Oct 2003 10:06:04 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA26905;
	Wed, 8 Oct 2003 11:05:53 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 8 Oct 2003 11:05:53 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Proposed NMI handling interface...
In-Reply-To: <3F832040.7070606@realitydiluted.com>
Message-ID: <Pine.GSO.3.96.1031008105647.26799A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 7 Oct 2003, Steven J. Hill wrote:

> I wanted to propose an NMI handling interface. I have attached
> the header file and patches to 'arch/mips/kernel/traps.c'. The
> user need only specify the offset address for the NMI vector
> code and then they can also specify their own desired NMI
> function. Comments?

 You should consider something like "#define nmi_user_handler ((void
(*)(struct pt_regs *))0)" for !CONFIG_NMI and possibly also a way to
return from the frontend gracefully if the backend says it's OK.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
