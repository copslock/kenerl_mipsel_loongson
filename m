Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76EEJD01652
	for linux-mips-outgoing; Mon, 6 Aug 2001 07:14:19 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76EEIV01649
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 07:14:18 -0700
Received: from localhost.localdomain (taarna.cygnus.com [205.180.230.102])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id HAA15634;
	Mon, 6 Aug 2001 07:14:15 -0700 (PDT)
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
From: Eric Christopher <echristo@redhat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: gcc@gcc.gnu.org, linux-mips@oss.sgi.com,
   GNU C Library
	 <libc-alpha@sourceware.cygnus.com>
In-Reply-To: <20010805094806.A3146@lucon.org>
References: <20010805094806.A3146@lucon.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 06 Aug 2001 15:12:56 +0100
Message-Id: <997107178.1253.7.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> I am working on will be the first gcc 3.x for Linux/mips. So there
> shouldn't be any problems. Am I right?

I _think_ you are ok doing this.

I just noticed from your patch that you set the size to 32-bits.  Please
set it to BITS_PER_WORD.

-eric

-- 
Look out behind you!
