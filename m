Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76ETGj04053
	for linux-mips-outgoing; Mon, 6 Aug 2001 07:29:16 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76ETDV04043;
	Mon, 6 Aug 2001 07:29:13 -0700
Received: from localhost.localdomain (taarna.cygnus.com [205.180.230.102])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id HAA16787;
	Mon, 6 Aug 2001 07:29:09 -0700 (PDT)
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
From: Eric Christopher <echristo@redhat.com>
To: Andreas Jaeger <aj@suse.de>
Cc: Ralf Baechle <ralf@oss.sgi.com>, "H . J . Lu" <hjl@lucon.org>,
   gcc@gcc.gnu.org, linux-mips@oss.sgi.com,
   GNU C Library
	 <libc-alpha@sourceware.cygnus.com>
In-Reply-To: <hoofptjy6k.fsf@gee.suse.de>
References: <20010805094806.A3146@lucon.org>
	<20010806115913.B17179@bacchus.dhis.org>  <hoofptjy6k.fsf@gee.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 06 Aug 2001 15:27:49 +0100
Message-Id: <997108072.1773.10.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > The MIPS ABI defines wchar_t to long.  So please go ahead and make the
> > change.
> 
> I'm confused.  The ABI defines it to be long - and he should change it
> nevertheless?
> 

Also depends on which MIPS ABI :)  I think it is ok to change though.


-- 
Look out behind you!
