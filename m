Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0CEaWu17659
	for linux-mips-outgoing; Sat, 12 Jan 2002 06:36:32 -0800
Received: from groucho.maths.monash.edu.au (groucho.maths.monash.edu.au [130.194.160.211])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0CEaQg17656
	for <linux-mips@oss.sgi.com>; Sat, 12 Jan 2002 06:36:26 -0800
Received: (from rjh@localhost)
	by groucho.maths.monash.edu.au (8.8.8/8.8.8) id NAA22217
	for linux-mips@oss.sgi.com; Sat, 12 Jan 2002 13:36:21 GMT
From: Robin Humble <rjh@groucho.maths.monash.edu.au>
Message-Id: <200201121336.NAA22217@groucho.maths.monash.edu.au>
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
To: linux-mips@oss.sgi.com
Date: Sun, 13 Jan 2002 00:36:21 +1100 (EDT)
In-Reply-To: <20020111214234.A5294@lucon.org> from "H . J . Lu" at Jan 11, 2002 09:42:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


H . J . Lu writes:
>On Fri, Jan 11, 2002 at 09:26:20PM -0800, Ralf Baechle wrote:
>> On Fri, Jan 11, 2002 at 12:08:06PM -0800, H . J . Lu wrote:
>> > > I don't know for sure just yet, the package takes a long time to compile.
>> > > The last time I compiled the package it failed to build - whether it is d
ue 
>> > > to the warnings or not I don't really know - maybe not. 
>> > libtool is very fragile. If it doesn't cause the failure, I won't touch
>> > it.
>> This bug may result in libraries not getting linked against certain other
>> libraries thus DT_NEEDED entries missing.  Frequently that's harmless but
>> it breaks a few packages.  I remember fixing this in a large number of
>> RH 7.0 packages.
>> 
>> Bug are rarely harmless just their consequences are subtle.

yeah, the libtool thing is a pain, but realistically it's only been a
problem for me on 2 or 3 out of many rpm builds. Still it'd be way cool
if it was sorted out...

>Ok. Please try
>ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/SRPMS/libtool-1.3.5-8.3.src.rpm

unfortunately this doesn't work. Same output as the orig 7.1 rpm or a
stock newer libtool :-/

Does the latest kernel export endianess in /proc/cpuinfo?
If so, then the latest rawhide rpm can be trivially modified to add
mips* along with s390* support in the s390 patch and it seems to work
for me. If your kernel doesn't export endianess, then you can specify
it with (eg. for big endian)
  ./configure --host=mips-unknown-linux-gnu ...
and libtool then works ok.

Grab a patched for mips libtool srpm (+ big endian binary rpms (Indy)) from
  http://www.cita.utoronto.ca/~rjh/mips/libtool/
Maybe someone can --rebuild the srpm on mipsel and see if it works too?

cheers,
robin
