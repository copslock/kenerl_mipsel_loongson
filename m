Received:  by oss.sgi.com id <S554005AbRBWBrC>;
	Thu, 22 Feb 2001 17:47:02 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:64761 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553995AbRBWBqv>;
	Thu, 22 Feb 2001 17:46:51 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f1N1gd828456;
	Thu, 22 Feb 2001 17:42:39 -0800
Message-ID: <3A95C0E2.5173DEA6@mvista.com>
Date:   Thu, 22 Feb 2001 17:46:10 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To:     Ralf Baechle <ralf@uni-koblenz.de>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: loops_per_sec
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Ralf,

The variable loops_per_sec has become loops_per_jiffy around 2.4.1,
breaking the mips delay functions.  I edited include/asm-mips/delay.h to
rename the variable.  There's other places in mips64 where loops_per_sec
is being used. Furthermore, since it's loops per "jiffy", the delay must
be further increased by a factor of HZ.  

Pete
