Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 13:13:33 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:63965 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225974AbTAHNNc>; Wed, 8 Jan 2003 13:13:32 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA03113;
	Wed, 8 Jan 2003 14:13:17 +0100 (MET)
Date: Wed, 8 Jan 2003 14:13:14 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@psi.cz>
cc: linux-mips <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Guido Guenther <agx@sigxcpu.org>
Subject: Re: Remove GIO interface
In-Reply-To: <20030108140818.C17162@erebor.psi.cz>
Message-ID: <Pine.GSO.3.96.1030108140756.1580E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 8 Jan 2003, Ladislav Michl wrote:

>                 ap = (struct archdata *)(mp->archdata_start);
> 
>                 if (ap->dbe_table_start == NULL ||
>                     !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
>                         continue;
> /* READ HERE: we don't reach this point because kernel is the last module
>  * and it is not initialized yet, so it has no archdata */

 Hmm, it would be good to have archdata_start and archdata_end initialized
statically for kernel_module.  Added to my to-do list. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
