Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6HHVHRw027798
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 10:31:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6HHVH9H027797
	for linux-mips-outgoing; Wed, 17 Jul 2002 10:31:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6HHVBRw027788
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 10:31:12 -0700
Received: from excalibur.cologne.de (p50850D8A.dip.t-dialin.net [80.133.13.138])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id TAA11625;
	Wed, 17 Jul 2002 19:35:48 +0200 (MET DST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 17UskJ-00007r-00; Wed, 17 Jul 2002 19:37:51 +0200
Date: Wed, 17 Jul 2002 19:37:51 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: Balakrishnan Ananthanarayanan <balakris_ananth@email.com>,
   linux-mips@oss.sgi.com
Subject: Re: 2.4.17 - compile error
Message-ID: <20020717193751.A251@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	Balakrishnan Ananthanarayanan <balakris_ananth@email.com>,
	linux-mips@oss.sgi.com
References: <20020717071503.17397.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020717071503.17397.qmail@email.com>; from balakris_ananth@email.com on Wed, Jul 17, 2002 at 02:15:03AM -0500
X-No-Archive: yes
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 17, 2002 at 02:15:03AM -0500, Balakrishnan Ananthanarayanan wrote:

> Hello all, 
> 
>     I'm compiling 2.4.17 to work for mips. I get the following error: 
> 
> mips_ksyms.c:44: parse error before 'this_object_must_be_defined_as_export_objs_in_the_Makefile' 
> 
> mips_ksyms.c:44: warning: type defaults to `int' in declaration of `this_object_must_be_defined_as_export_objs_in_the_Makefile'
> 
> mips_ksyms.c:44: warning: data definition has no type or storage class
> 
> The same errors repeat themselves at certain line numbers till line 140. What shud I do? Please help. 

Which kernel tree do you try to compile and which target system do you want
to build a kernel for? AFAIK the vanilla 2.4.17 will not build for mips
at all, so you have to use a kernel tree with proper support for your 
target system (e.g. the one at oss.sgi.com).

HTH,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
