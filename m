Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f37GOU125926
	for linux-mips-outgoing; Sat, 7 Apr 2001 09:24:30 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f37GOTM25923
	for <linux-mips@oss.sgi.com>; Sat, 7 Apr 2001 09:24:29 -0700
Received: from redhat.com (dhcp-248.hsv.redhat.com [172.16.17.248] (may be forged))
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id JAA06703;
	Sat, 7 Apr 2001 09:23:50 -0700 (PDT)
Message-ID: <3ACF323D.3030704@redhat.com>
Date: Sat, 07 Apr 2001 10:29:01 -0500
From: Joe deBlaquiere <jadb@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; 0.8) Gecko/20010217
X-Accept-Language: en
MIME-Version: 1.0
CC: "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
References: <Pine.GSO.3.96.1010404153012.6521E-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Maciej W. Rozycki wrote:

> On Wed, 4 Apr 2001, Ralf Baechle wrote:
> 
> 
>> stdint.h isn't available everywhere.  Aside of that I won't object ...
> 
> 
>  That's why I wrote of legacy hosts.  The AC_CHECK_HEADERS and
> AC_CHECK_TYPE macros are cross-compilation-safe and they are all that
> modern hosts need.  For other hosts AC_CHECK_SIZEOF might be used to find
> generic types suitable for ISO C definitions, which might be problematic
> for cross-compilation, though.  Still this applies to non-gcc
> cross-compilers only, which are not that common, AFAIK.

You might call it a hack, but it makes life easy if you do something like:

export ac_cv_sizeof_short=2
export ac_cv_sizeof_int=4
export ac_cv_sizeof_long=4

sh ./configure --target=$CONFIG_TARGET --host=$CONFIG_HOST 
--prefix=$CONFIG_PREFIX --exec-prefix=$CONFIG_EXECPR

This will short circuit a "broken" configure trying to execute programs 
for this kind of thing. If configure doesn't care about sizeof_int, then 
this definition is silently ignored...

-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
