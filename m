Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6H7AERw030804
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 00:10:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6H7AEkF030802
	for linux-mips-outgoing; Wed, 17 Jul 2002 00:10:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ws3-5.us4.outblaze.com (205-158-62-95.outblaze.com [205.158.62.95])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6H7AARw030757
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 00:10:10 -0700
Received: (qmail 17399 invoked by uid 1001); 17 Jul 2002 07:15:03 -0000
Message-ID: <20020717071503.17397.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Received: from [202.140.142.131] by ws3-5.us4.outblaze.com with http for
    balakris_ananth@email.com; Wed, 17 Jul 2002 02:15:03 -0500
From: "Balakrishnan Ananthanarayanan" <balakris_ananth@email.com>
To: linux-mips@oss.sgi.com, linux-kernel@vger.kernel.org,
   redhat-list@redhat.com
Date: Wed, 17 Jul 2002 02:15:03 -0500
Subject: 2.4.17 - compile error
X-Originating-Ip: 202.140.142.131
X-Originating-Server: ws3-5.us4.outblaze.com
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello all, 

    I'm compiling 2.4.17 to work for mips. I get the following error: 

mips_ksyms.c:44: parse error before 'this_object_must_be_defined_as_export_objs_in_the_Makefile' 

mips_ksyms.c:44: warning: type defaults to `int' in declaration of `this_object_must_be_defined_as_export_objs_in_the_Makefile'

mips_ksyms.c:44: warning: data definition has no type or storage class

The same errors repeat themselves at certain line numbers till line 140. What shud I do? Please help. 

Thanks, 
Balakrishnan

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Save up to $160 by signing up for NetZero Platinum Internet service.
http://www.netzero.net/?refcd=N2P0602NEP8
