Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4UErRn30075
	for linux-mips-outgoing; Wed, 30 May 2001 07:53:27 -0700
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4UErPh30072
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 07:53:25 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id HAA01791
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 07:53:19 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id KAA10025 for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 10:48:58 -0400
Date: Wed, 30 May 2001 10:48:58 -0400
From: "J. Scott Kasten" <jsk@tetracon-eng.net>
To: <linux-mips@oss.sgi.com>
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel 
In-Reply-To: <200105291545.IAA13454@saturn.mikemac.com>
Message-ID: <Pine.SGI.4.33.0105301047290.8607-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> >All the cases I've seen have been for 32-bit kernels. A 64-bit PDA kernel seems like a wee tiny bit of overkill
>
>   I've been asked about running 64 bit binaries on a VR4121.

Unless you're doing encryption in an embedded device, then 64 bit regs are
quite nice...
