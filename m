Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6UK4TRw001870
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 13:04:29 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6UK4TaJ001869
	for linux-mips-outgoing; Tue, 30 Jul 2002 13:04:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.redhat.com (mx2.redhat.com [205.180.83.106])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6UK4ORw001860
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 13:04:24 -0700
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id g6UJp2s12887;
	Tue, 30 Jul 2002 15:51:02 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id g6UK5Wu25663;
	Tue, 30 Jul 2002 16:05:33 -0400
Received: from localhost.localdomain (remus.sfbay.redhat.com [172.16.27.252])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id g6UK5Vm27037;
	Tue, 30 Jul 2002 13:05:31 -0700
Subject: Re: PATCH: Update E_MIP_ARCH_XXX (Re: [patch] linux: RFC:
	elf_check_arch() rework)
From: Eric Christopher <echristo@redhat.com>
To: cgd@broadcom.com
Cc: dant@mips.com, Carsten Langgaard <carstenl@mips.com>, hjl@lucon.org,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com,
   binutils@sources.redhat.com
In-Reply-To: <yov5k7ndkodv.fsf@broadcom.com>
References: <3D44F31D.55155E24@mips.com>
	<Pine.LNX.4.44.0207301606350.31951-100000@coplin18.mips.com>
	<mailpost.1028038253.3155@news-sj1-1> <yov5n0s9koo6.fsf@broadcom.com> 
	<yov5k7ndkodv.fsf@broadcom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Jul 2002 13:03:52 -0700
Message-Id: <1028059433.19879.22.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
X-Spam-Status: No, hits=-1.6 required=5.0 tests=IN_REP_TO,SUBJ_HAS_SPACES,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2002-07-30 at 12:27, cgd@broadcom.com wrote:
> At 30 Jul 2002 12:20:57 -0700, Chris G. Demetriou wrote:
> > I've made an inquiry, and my understanding is that Cygnus/RedHat
> > internally use the same values as the public tools
> > (i.e. EF_MIPS_ARCH_MIPS32 == 5, ..._MIPS64 == 6).
> 
> Of course, i typo'd most of the names of the constants in my msg.  I
> meant E_MIPS_ARCH_32, etc., obviously.  8-)

We have nothing different from what the sources on the net use.

-eric

-- 
I don't want a pony, I want a rocket
powered jetpack!
