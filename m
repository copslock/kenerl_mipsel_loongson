Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76H65X17930
	for linux-mips-outgoing; Mon, 6 Aug 2001 10:06:05 -0700
Received: from perceval.inria.fr (IDENT:root@perceval.inria.fr [138.96.116.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76H61V17926;
	Mon, 6 Aug 2001 10:06:01 -0700
Received: by perceval.inria.fr (8.11.1/8.10.0) id f76H4aC17454; Mon, 6 Aug 2001 19:04:36 +0200
From: Gabriel Dos_Reis <gdosreis@sophia.inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon,  6 Aug 2001 19:04:36 +0200 (MEST)
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Andreas Jaeger <aj@suse.de>, "H . J . Lu" <hjl@lucon.org>,
   Eric Christopher <echristo@redhat.com>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
In-Reply-To: <20010806182050.A21142@bacchus.dhis.org>
References: <20010805094806.A3146@lucon.org>
	<20010806115913.B17179@bacchus.dhis.org>
	<hoofptjy6k.fsf@gee.suse.de>
	<20010806182050.A21142@bacchus.dhis.org>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15214.52694.346958.536105@perceval.inria.fr>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


| > I'm confused.  The ABI defines it to be long - and he should change it
| > nevertheless?
| 
| It's defined as a "long", not "long int" so we're obviously off by a tiny
| bit.

As far as far C++ is concerned, there is no pedantic difference
between "long" and "long int" and "signed long int".

-- Gaby
