Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0224o530860
	for linux-mips-outgoing; Tue, 1 Jan 2002 18:04:50 -0800
Received: from rover.village.org (warner@rover.bsdimp.com [204.144.255.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0224mg30857
	for <linux-mips@oss.sgi.com>; Tue, 1 Jan 2002 18:04:48 -0800
Received: from harmony.village.org (harmony.village.org [10.0.0.6])
	by rover.village.org (8.11.3/8.11.3) with ESMTP id g0214fl40709;
	Tue, 1 Jan 2002 18:04:42 -0700 (MST)
	(envelope-from imp@village.org)
Received: from localhost (localhost [127.0.0.1])
	by harmony.village.org (8.11.6/8.11.6) with ESMTP id g0214dF06257;
	Tue, 1 Jan 2002 18:04:40 -0700 (MST)
	(envelope-from imp@village.org)
Date: Tue, 01 Jan 2002 18:03:43 -0700 (MST)
Message-Id: <20020101.180343.38230768.imp@village.org>
To: brad@ltc.com
Cc: jsun@mvista.com, jim@jtan.com, alan@lxorguk.ukuu.org.uk,
   Geert.Uytterhoeven@sonycom.com, macro@ds2.pg.gda.pl, linux-mips@oss.sgi.com
Subject: Re: ISA
From: "M. Warner Losh" <imp@village.org>
In-Reply-To: <016d01c192fb$518a9dd0$5601010a@prefect>
References: <20011221134452.A21586@neurosis.mit.edu>
	<20020101112223.A14847@mvista.com>
	<016d01c192fb$518a9dd0$5601010a@prefect>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

You should look at BSD's bus_space.  IT solves this problem without
having to put architecturally specific kludged into each driver.

Warner
