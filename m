Received:  by oss.sgi.com id <S42240AbQHBI3a>;
	Wed, 2 Aug 2000 01:29:30 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:49784 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42236AbQHBI3B>;
	Wed, 2 Aug 2000 01:29:01 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA26641
	for <linux-mips@oss.sgi.com>; Wed, 2 Aug 2000 01:20:57 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id BAA03600 for <linux-mips@oss.sgi.com>; Wed, 2 Aug 2000 01:26:44 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA96327
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Aug 2000 01:25:12 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA04082
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Aug 2000 01:25:10 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA29838;
	Wed, 2 Aug 2000 01:23:56 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA15451;
	Wed, 2 Aug 2000 01:23:52 -0700 (PDT)
Message-ID: <008601bffc5b$6714c0a0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Jun Sun" <jsun@mvista.com>, <linux@cthulhu.engr.sgi.com>,
        <linux-mips@fnet.fr>, <ralf@oss.sgi.com>
Subject: Re: PROPOSAL : multi-way cache support in Linux/MIPS
Date:   Wed, 2 Aug 2000 10:26:38 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0083_01BFFC6C.24323180"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.

------=_NextPart_000_0083_01BFFC6C.24323180
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Rather than re-invent the wheel, please consider the
cache descriptor data structures we developed at
MIPS to deal with this problem.  I believe that the
updated cache.h file, and maybe even the cpu_probe.c
file, was checked into the 2.2 repository at SGI long ago.
There are also a set of initialisation and invalidation routines
that key off the cache descriptor structure, but those aren't
in the SGI  repository (though anyone can get them from
ftp.mips.com or www.paralogos.com).  The CPU probe
logic (also on those sites, and already integrated
into several variants because it also supports setting
up state needed by the software FPU emulation)
is table-based, and for each PrID value, there is
a template for the cache characteristics, which
can either be taken "as is" or probed, depending
on a flag in the descriptor.  Since the number of
"ways" cannot always be determined by probing,
if the number of ways is specified, it is preserved
even if a cache probe is performed.   I won't attach the
full set of cache probe routines (which would only confuse
things), but here is the cache data structure definition
and the CPU descriptor template table that we use.

            Regads,

            Kevin K.

-----Original Message-----
From: Jun Sun <jsun@mvista.com>
To: linux@cthulhu.engr.sgi.com <linux@cthulhu.engr.sgi.com>;
linux-mips@fnet.fr <linux-mips@fnet.fr>; ralf@oss.sgi.com <ralf@oss.sgi.com>
Date: Wednesday, August 02, 2000 2:01 AM
Subject: PROPOSAL : multi-way cache support in Linux/MIPS


>Ralf,
>
>I have got NEC DDB5476 running stable enough that I am comfortable to
>check in
>my code.  Will you take it?
>
>Assuming the answer is yes, there are several issues regarding checking
>in.
>I will bring them up one by one.
>
>The first issue is multi-way cache support.  DDB5476 uses R5432 CPU
>which
>has two-way set-associative cache.  The problematic part is the
>index-based cache operations in r4xxcache.h does not cover all ways in a
>set.
>
>I think this is a problem in general.  So far I have seen MIPS
>processors with
>2-way, 4-way and 8-way sets.  And I have seen them using ether least-
>significant-addressing-bits or most-significant-addressing-bits
>within a cache line to select ways.
>
>Here is my proposal :
>
>. introduce two variables,
>        cache_num_ways - number of ways in a set
>        cache_way_selection_offset - the offset added to the address to
>select
>                next cache line in the same set.  For LSBs addressing,
>it is
>                equal to 1.  For MSBs addressing, it is equal to
>                cache_line_size / cache_num_ways.  (It can potentially
>take
>                care of some future weired way-selection scheme as long
>as
>                the offset is uniform)
>
>. These variables are initialized in cpu_probe().
>
>  (Alternatively, I think we should have cpu_info table, that contains
>all
>   these cpu information.  Then a general routine can fill in the based
>on
>   the cpu id.  This can get rid of a bunch of ugly switch/case
>statements.)
>
>. in the include/asm/r4kcache.h file, all Index-based cache operation
>needs
>  to changed like the following (for illustration only; need
>optimization) :
>
>-----
>        while(start < end) {
>                cache16_unroll32(start,Index_Writeback_Inv_D);
>                start += 0x200;
>        }
>+++++
>        while(start < end) {
>                for (i=0; i< cache_num_ways; i++) {
>                        cache16_unroll32(start +
>i*cache_way_selection_offset,
>                                         Index_Writeback_Inv_D);
>                }
>                start += 0x200;
>        }
>=====
>
>What do you think?  If it is OK, I can do the patch.  The cpu_info table
>is a nice wish, but I don't think I know enough to do that job yet.
>
>Jun

------=_NextPart_000_0083_01BFFC6C.24323180
Content-Type: application/octet-stream;
	name="cache.h"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="cache.h"

LyoKICogaW5jbHVkZS9hc20tbWlwcy9jYWNoZS5oCiAqLwovKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKICog
IDcgRGVjLCAxOTk5LgogKiAgQWRkZWQgZGVmaW5pdGlvbiBvZiBjYWNoZSBkZXNjcmlwdG9yIHN0
cnVjdHVyZS4KICoKICogIEtldmluIEQuIEtpc3NlbGwsIGtldmlua0BtaXBzLmNvbQogKiAgQ29w
eXJpZ2h0IChDKSAxOTk5IE1JUFMgVGVjaG5vbG9naWVzLCBJbmMuICBBbGwgcmlnaHRzIHJlc2Vy
dmVkLgogKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKi8KCiNpZm5kZWYgX19BU01fTUlQU19DQUNIRV9ICiNkZWZp
bmUgX19BU01fTUlQU19DQUNIRV9ICgojaWZuZGVmIF9MQU5HVUFHRV9BU1NFTUJMWQovKgogKiBE
ZXNjcmlwdG9yIGZvciBhIGNhY2hlCiAqLwoKc3RydWN0IGNhY2hlX2Rlc2MgewogICAgICAgIGlu
dCBsaW5lc3o7CiAgICAgICAgaW50IHNldHM7CiAgICAgICAgaW50IHdheXM7CiAgICAgICAgaW50
IGZsYWdzOyAgICAgIC8qIERldGFpbHMgbGlrZSB3cml0ZSB0aHJ1L2JhY2ssIGNvaGVyZW50LCBl
dGMuICovCn07CgojZW5kaWYKLyoKICogRmxhZyBkZWZpbml0aW9ucwogKi8KCiNkZWZpbmUgTUlQ
U19DQUNIRV9ORUVEU19DT05GSUcJMHgwMDAwMDAwMQojZGVmaW5lIE1JUFNfQ0FDSEVfVklSVFVB
TAkweDAwMDAwMDAyICAvKiBWaXJ0dWFsbHkgdGFnZ2VkICovCgovKiBieXRlcyBwZXIgTDEgY2Fj
aGUgbGluZSAqLwoKLyogCiAqIEl0IHdvdWxkIGJlIG5pY2UgdG8gbWFrZSB0aGlzIGR5bmFtaWMs
IAogKiBiYXNlZCBvbiBtaXBzX2NwdS5kY2FjaGUubGluZXN6LCBidXQKICogaXQgaXMgdXNlZCBm
b3IgZml4ZWQtc2l6ZSBzdHJ1Y3R1cmUgYWxsb2NhdGlvbi4KICogU2V0IHRvIGtub3duIG1heGlt
dW0gZm9yIE1JUFMgYXJjaGl0ZWN0dXJlLCAzMiBieXRlcy4KICovCgojZGVmaW5lICAgICAgICBM
MV9DQUNIRV9CWVRFUyAgMzIKCgojZGVmaW5lICAgICAgICBMMV9DQUNIRV9BTElHTih4KSAgICAg
ICAoKCh4KSsoTDFfQ0FDSEVfQllURVMtMSkpJn4oTDFfQ0FDSEVfQllURVMtMSkpCgojZGVmaW5l
ICAgICAgICBTTVBfQ0FDSEVfQllURVMgTDFfQ0FDSEVfQllURVMKCiNlbmRpZiAvKiBfX0FTTV9N
SVBTX0NBQ0hFX0ggKi8K

------=_NextPart_000_0083_01BFFC6C.24323180
Content-Type: application/octet-stream;
	name="cpu.h"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="cpu.h"

LyogJElkOiBjcHUuaCx2IDEuNSAyMDAwLzAyLzE2IDIxOjQ2OjI5IGtldmluayBFeHAgJAogKiBj
cHUuaDogVmFsdWVzIG9mIHRoZSBQUklkIHJlZ2lzdGVyIHVzZWQgdG8gbWF0Y2ggdXAKICogICAg
ICAgIHZhcmlvdXMgTUlQUyBjcHUgdHlwZXMuCiAqCiAqIENvcHlyaWdodCAoQykgMTk5NiBEYXZp
ZCBTLiBNaWxsZXIgKGRtQGVuZ3Iuc2dpLmNvbSkKICoKICovCi8qKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgog
KiAgNyBEZWMsIDE5OTkuCiAqICBBZGRlZCA0S0MgYW5kIDVLQyBQUl9JRCBjb2RlcywgYW5kIGRl
ZmluZWQgbWlwc19jcHUgZGF0YSBzdHJ1Y3R1cmUKICogIGFuZCBmaWVsZCBlbmNvZGluZ3MuCiAq
CiAqICBLZXZpbiBELiBLaXNzZWxsLCBrZXZpbmtAbWlwcy5jb20KICogIENvcHlyaWdodCAoQykg
MTk5OSBNSVBTIFRlY2hub2xvZ2llcywgSW5jLiAgQWxsIHJpZ2h0cyByZXNlcnZlZC4KICoqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKiovCgojaWZuZGVmIF9NSVBTX0NQVV9ICiNkZWZpbmUgX01JUFNfQ1BVX0gKCi8q
CiAqIEFzc2lnbmVkIHZhbHVlcyBmb3IgdGhlIHByb2R1Y3QgSUQgcmVnaXN0ZXIuICBJbiBvcmRl
ciB0byBkZXRlY3QgYQogKiBjZXJ0YWluIENQVSB0eXBlIGV4YWN0bHkgZXZlbnR1YWxseSBhZGRp
dGlvbmFsIHJlZ2lzdGVycyBtYXkgbmVlZCB0bwogKiBiZSBleGFtaW5lZC4KICovCiNkZWZpbmUg
UFJJRF9JTVBfUjIwMDAgICAgMHgwMTAwCiNkZWZpbmUgUFJJRF9JTVBfUjMwMDAgICAgMHgwMjAw
CiNkZWZpbmUgUFJJRF9JTVBfUjYwMDAgICAgMHgwMzAwCiNkZWZpbmUgUFJJRF9JTVBfUjQwMDAg
ICAgMHgwNDAwCiNkZWZpbmUgUFJJRF9JTVBfUjYwMDBBICAgMHgwNjAwCiNkZWZpbmUgUFJJRF9J
TVBfUjEwMDAwICAgMHgwOTAwCiNkZWZpbmUgUFJJRF9JTVBfUjQzMDAgICAgMHgwYjAwCiNkZWZp
bmUgUFJJRF9JTVBfUjgwMDAgICAgMHgxMDAwCiNkZWZpbmUgUFJJRF9JTVBfUjQ2MDAgICAgMHgy
MDAwCiNkZWZpbmUgUFJJRF9JTVBfUjQ3MDAgICAgMHgyMTAwCiNkZWZpbmUgUFJJRF9JTVBfUjQ2
NDAgICAgMHgyMjAwCiNkZWZpbmUgUFJJRF9JTVBfUjQ2NTAgICAgMHgyMjAwCQkvKiBTYW1lIGFz
IFI0NjQwICovCiNkZWZpbmUgUFJJRF9JTVBfUjUwMDAgICAgMHgyMzAwCiNkZWZpbmUgUFJJRF9J
TVBfU09OSUMgICAgMHgyNDAwCiNkZWZpbmUgUFJJRF9JTVBfTUFHSUMgICAgMHgyNTAwCiNkZWZp
bmUgUFJJRF9JTVBfUk03MDAwICAgMHgyNzAwCiNkZWZpbmUgUFJJRF9JTVBfTkVWQURBICAgMHgy
ODAwCQkvKiBSTTUyNjAgPz8/ICovCiNkZWZpbmUgUFJJRF9JTVBfNEtDICAgICAgMHg4MDAwCiNk
ZWZpbmUgUFJJRF9JTVBfNUtDICAgICAgMHg4MTAwCgojZGVmaW5lIFBSSURfSU1QX1VOS05PV04g
IDB4ZmYwMAoKI2RlZmluZSBQUklEX1JFVl9SNDQwMCAgICAweDAwNDAKI2RlZmluZSBQUklEX1JF
Vl9SMzAwMEEgICAweDAwMzAKI2RlZmluZSBQUklEX1JFVl9SMzAwMCAgICAweDAwMjAKI2RlZmlu
ZSBQUklEX1JFVl9SMjAwMEEgICAweDAwMTAKCgojaW5jbHVkZSA8YXNtL2NhY2hlLmg+CgojaWZu
ZGVmICBfTEFOR1VBR0VfQVNTRU1CTFkKLyoKICogQ2FwYWJpbGl0eSBhbmQgZmVhdHVyZSBkZXNj
cmlwdG9yIHN0cnVjdHVyZSBmb3IgTUlQUyBDUFUKICovCgpzdHJ1Y3QgbWlwc19jcHUgewoJdW5z
aWduZWQgaW50IHByb2Nlc3Nvcl9pZDsKCXVuc2lnbmVkIGludCBjcHV0eXBlOwkJLyogT2xkICJt
aXBzX2NwdXR5cGUiIGNvZGUgKi8KCWludCBpc2FfbGV2ZWw7CglpbnQgb3B0aW9uczsKCWludCB0
bGJzaXplOwoJc3RydWN0IGNhY2hlX2Rlc2MgaWNhY2hlOwkvKiBQcmltYXJ5IEktY2FjaGUgKi8K
CXN0cnVjdCBjYWNoZV9kZXNjIGRjYWNoZTsJLyogUHJpbWFyeSBEIG9yIGNvbWJpbmVkIEkvRCBj
YWNoZSAqLwoJc3RydWN0IGNhY2hlX2Rlc2Mgc2NhY2hlOwkvKiBTZWNvbmRhcnkgY2FjaGUgKi8K
CXN0cnVjdCBjYWNoZV9kZXNjIHRjYWNoZTsJLyogVGVydGlhcnkvc3BsaXQgc2Vjb25kYXJ5IGNh
Y2hlICovCn07CgojZW5kaWYKCi8qCiAqIElTQSBMZXZlbCBlbmNvZGluZ3MgCiAqLwoKI2RlZmlu
ZSBNSVBTX0NQVV9JU0FfSQkJMHgwMDAwMDAwMQojZGVmaW5lIE1JUFNfQ1BVX0lTQV9JSQkJMHgw
MDAwMDAwMgojZGVmaW5lIE1JUFNfQ1BVX0lTQV9JSUkJMHgwMDAwMDAwMwojZGVmaW5lIE1JUFNf
Q1BVX0lTQV9JVgkJMHgwMDAwMDAwNAojZGVmaW5lIE1JUFNfQ1BVX0lTQV9WCQkweDAwMDAwMDA1
CiNkZWZpbmUgTUlQU19DUFVfSVNBX00zMgkweDAwMDAwMDIwCiNkZWZpbmUgTUlQU19DUFVfSVNB
X002NAkweDAwMDAwMDQwCgovKgogKiBDUFUgT3B0aW9uIGVuY29kaW5ncyAKICovIAoKI2RlZmlu
ZSBNSVBTX0NQVV9UTEIJMHgwMDAwMDAwMQkvKiBDUFUgaGFzIFRMQiAqLwovKiBMZWF2ZSBhIHNw
YXJlIGJpdCBmb3IgdmFyaWFudCBNTVUgdHlwZXMuLi4gKi8KI2RlZmluZSBNSVBTX0NQVV80S0VY
CTB4MDAwMDAwMDQJLyogIlI0SyIgZXhjZXB0aW9uIG1vZGVsICovCiNkZWZpbmUgTUlQU19DUFVf
NEtUTEIJMHgwMDAwMDAwOAkvKiAiUjRLIiBUTEIgaGFuZGxlciAqLwojZGVmaW5lIE1JUFNfQ1BV
X0ZQVQkweDAwMDAwMDEwCS8qIENQVSBoYXMgRlBVICovCiNkZWZpbmUgTUlQU19DUFVfMzJGUFIJ
MHgwMDAwMDAyMAkvKiAzMiBkYmwuIHByZWMuIEZQIHJlZ2lzdGVycyAqLwojZGVmaW5lIE1JUFNf
Q1BVX0NPVU5URVIgMHgwMDAwMDA0MAkvKiBDeWNsZSBjb3VudC9jb21wYXJlICovCiNkZWZpbmUg
TUlQU19DUFVfV0FUQ0gJMHgwMDAwMDA4MAkvKiB3YXRjaHBvaW50IHJlZ2lzdGVycyAqLwojZGVm
aW5lIE1JUFNfQ1BVX01JUFMxNgkweDAwMDAwMTAwCS8qIGNvZGUgY29tcHJlc3Npb24gKi8KI2Rl
ZmluZSBNSVBTX0NQVV9ESVZFQwkweDAwMDAwMjAwCS8qIGRlZGljYXRlZCBpbnRlcnJ1cHQgdmVj
dG9yICovCiNkZWZpbmUgTUlQU19DUFVfVkNFCTB4MDAwMDA0MDAJLyogdmlydC4gY29oZXJlbmNl
IGNvbmZsaWN0IHBvc3NpYmxlICovCiNkZWZpbmUgTUlQU19DUFVfQ0FDSEVfQ0RFWCAweDAwMDAw
ODAwCS8qIENyZWF0ZV9EaXJ0eV9FeGNsdXNpdmUgQ0FDSEUgb3AgKi8KCiNlbmRpZiAvKiAhKF9N
SVBTX0NQVV9IKSAqLwo=

------=_NextPart_000_0083_01BFFC6C.24323180
Content-Type: application/octet-stream;
	name="cpu_probe.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="cpu_probe.c"

LyogJElkOiBjcHVfcHJvYmUuYyx2IDEuMTEgMjAwMC8wNy8wNyAwOTowMjozNiBjYXJzdGVubCBF
eHAgJCAKICoKICogY3B1X3Byb2JlLmMKICoKICogS2V2aW4gRC4gS2lzc2VsbCwga2V2aW5rQG1p
cHMuY29tCiAqIENvcHlyaWdodCAoQykgMTk5OSwyMDAwIE1JUFMgVGVjaG5vbG9naWVzLCBJbmMu
ICBBbGwgcmlnaHRzIHJlc2VydmVkLgogKgogKiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKICoKICogIFRoaXMg
cHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIGRpc3RyaWJ1dGUgaXQgYW5kL29yIG1v
ZGlmeSBpdAogKiAgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSAoVmVyc2lvbiAyKSBhcwogKiAgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZv
dW5kYXRpb24uCiAqCiAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
aXQgd2lsbCBiZSB1c2VmdWwsIGJ1dCBXSVRIT1VUCiAqICBBTlkgV0FSUkFOVFk7IHdpdGhvdXQg
ZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZiBNRVJDSEFOVEFCSUxJVFkgb3IKICogIEZJVE5F
U1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZQogKiAgZm9yIG1vcmUgZGV0YWlscy4KICoKICogIFlvdSBzaG91bGQgaGF2ZSByZWNl
aXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFsb25nCiAqICB3
aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uLCBJbmMuLAogKiAgNTkgVGVtcGxlIFBsYWNlIC0gU3VpdGUgMzMwLCBCb3N0b24gTUEg
MDIxMTEtMTMwNywgVVNBLgogKgogKiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKICoKICogQyBjb2RlLCBjYWxs
ZWQgZnJvbSBzdGFydHVwIHZlY3RvciB0byBkZWNvZGUgdGhlIENQVSBjb25maWd1cmF0aW9uIGFu
ZCAKICogc2V0IHVwIHRoZSBtaXBzX2NwdSBkYXRhIHN0cnVjdHVyZSwgdXNlZCBieSB0aGUga2Vy
bmVsIHRvIGFic3RyYWN0IG91dCAKICogbW9zdCBpbXBsZW1lbnRhdGlvbiBvcHRpb25zIG9mIE1J
UFMgQ1BVcy4KICoKICovCgojaW5jbHVkZSA8YXNtL2NwdS5oPgojaW5jbHVkZSA8YXNtL2Jvb3Rp
bmZvLmg+CiNpbmNsdWRlIDxhc20vaW5pdC5oPgoKI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPgoK
I2lmZGVmIENPTkZJR19DUFVfTUlQUzMyCmV4dGVybiB2b2lkIG1pcHMzMl9jcHVfcHJvYmUodW5z
aWduZWQgaW50IHByX2lkKTsKI2VuZGlmCgovKiBkZWNsYXJhdGlvbiBvZiB0aGUgZ2xvYmFsIHN0
cnVjdCAqLwpzdHJ1Y3QgbWlwc19jcHUgbWlwc19jcHUgPSB7UFJJRF9JTVBfVU5LTk9XTiwgQ1BV
X1VOS05PV04sIDAsIDAsIDAsCgkJCQl7MCwwLDAsMH0sIHswLDAsMCwwfSwgezAsMCwwLDB9LCB7
MCwwLDAsMH19OwoKLyogU2hvcnRjdXQgZm9yIGFzc2VtYmxlciBhY2Nlc3MgdG8gbWlwc19jcHUu
b3B0aW9ucyAqLwoKaW50ICpjcHVvcHRpb25zID0gJm1pcHNfY3B1Lm9wdGlvbnM7CgovKgogKiBD
YW5uZWQgZGVzY3JpcHRvcnMgb2YgTUlQUyBDUFVzLiBOb3RlIHRoYXQgZm9yIHRoZSBjb2RlIGJl
bG93CiAqIHRvIGZ1bmN0aW9uIGNvcnJlY3RseSwgYSBnZW5lcmljIGRlc2NyaXB0aW9uIHdpdGgg
YSBwcm9jZXNzb3JfaWQKICogdmFsdWUgd2l0aCBubyBpbXBsZW1lbnRhdGlvbiBiaXRzIHNldCBt
dXN0IGZvbGxvdyBhbnkgZGVzY3JpcHRpb25zCiAqIG9mIGRpc3RpbmN0IHZhcmlhbnQgcmV2aXN0
aW9ucywgaS5lLiBSNDAwMCBtdXN0IHByZWNlZGUgUjQ0MDAsCiAqIFIzMDAwIG11c3QgcHJlY2Vk
ZSBSMzAwMEEuICBNYW55IENQVXMgYXJlIG5vdCByZWZsZWN0ZWQgaW4KICogdGhlIGxpc3QuICBO
ZXcgZW50cmllcyByZXF1aXJlIHRoZSBhZGR0aW9uIG9mIFBSX0lEIHJlZ2lzdGVyCiAqIGRhdGEg
aW4gYXNtL2NwdS5oIGFuZCBhc3NpZ25tZW50IG9mIGEgQ1BVXyBjb2RlIGluIGFzbS9ib290aW5m
by5oLgogKiBUaGUgbWlwc19jcHUgc3RydWN0dXJlIGlzIGRlZmluZWQgaW4gYXNtL2NwdS5oIGFu
ZCBhc20vY2FjaGUuaC4KICovCgovKgogKiBTb21lIG9wdGlvbnMgYXJlIGNvbW1vbiBhY3Jvc3Mg
YWxsIFI0MDAwIGRlcml2YXRpdmVzCiAqLwoKI2RlZmluZSBSNEtfT1BUUyAoTUlQU19DUFVfVExC
IHwgTUlQU19DUFVfNEtFWCB8IE1JUFNfQ1BVXzRLVExCIFwKCQl8IE1JUFNfQ1BVX0NPVU5URVIg
fCBNSVBTX0NQVV9DQUNIRV9DREVYICkKCnN0YXRpYyBzdHJ1Y3QgbWlwc19jcHUgX19pbml0ZGF0
YSBtaXBzX2NwdV90ZW1wbGF0ZVtdID0gewoJLyogUjIwMDAgKi8KCXsgUFJJRF9JTVBfUjIwMDAs
IAkvKiBQUl9JRCByZWdpc3RlciB2YWx1ZSAqLwoJICBDUFVfUjIwMDAsIAkJLyogS2VybmVsIGlu
dGVybmFsIENQVSBpZGVudGlmaWVyICovCgkgIE1JUFNfQ1BVX0lTQV9JLCAJLyogTUlQUyBJU0Eg
bGV2ZWwgKi8KCSAgTUlQU19DUFVfVExCLCAJLyogRmxhZ3MgZm9yIGltcGxlbWVudGF0aW9uIG9w
dGlvbnMgKi8KCSAgMzIsCQkJLyogTnVtYmVyIG9mIFRMQiBlbnRyaWVzICovCgkgIHswLDAsMCww
fSwgCQkvKiBJLWNhY2hlIGxpbmUgc2l6ZSwgI3NldHMsICN3YXlzLCBmbGFncyAqLwoJICB7MCww
LDAsTUlQU19DQUNIRV9ORUVEU19DT05GSUd9LCAvKiBVbmlmaWVkL0QtY2FjaGUgZGVzY3JpcHRv
ciAqLwoJICB7MCwwLDAsMH0sIAkJLyogUy1jYWNoZSBkZXNjcmlwdG9yICovCgkgIHswLDAsMCww
fX0sCQkvKiBUZXJ0aWFyeSBjYWNoZSBkZXNjcmlwdG9yICovCgkvKiBNSVBTIDRLYyAqLwoJeyBQ
UklEX0lNUF80S0MsIENQVV80S0MsICBNSVBTX0NQVV9JU0FfTTMyLCBNSVBTX0NQVV9UTEIgfCAK
CSAgICAgICAgTUlQU19DUFVfNEtFWCB8IE1JUFNfQ1BVXzRLVExCIHwgTUlQU19DUFVfQ09VTlRF
UiB8IAoJICAgICAgICBNSVBTX0NQVV9ESVZFQyB8IE1JUFNfQ1BVX1dBVENILCAxNiwgCgkgICAg
ICAgIHsxNiwgMjU2LCA0LCAwfSwgezE2LCAyNTYsIDQsIDB9LCB7MCwwLDAsMH0sIHswLDAsMCww
fX0sCgkvKiBNSVBTIDVLYyAqLwoJeyBQUklEX0lNUF81S0MsIENQVV81S0MsICBNSVBTX0NQVV9J
U0FfTTY0LCBNSVBTX0NQVV9UTEIgfCAKCSAgICAgICAgTUlQU19DUFVfNEtFWCB8IE1JUFNfQ1BV
XzRLVExCIHwgTUlQU19DUFVfQ09VTlRFUiB8IAoJICAgICAgICBNSVBTX0NQVV9ESVZFQyB8IE1J
UFNfQ1BVX1dBVENILCAzMiwKCSAgICAgICAgezMyLCAxMjgsIDQsIDB9LCB7MzIsIDEyOCwgNCwg
MH0sIHswLDAsMCwwfSwgezAsMCwwLDB9fSwKCS8qIFIzMDAwICovCgl7IFBSSURfSU1QX1IzMDAw
LCBDUFVfUjMwMDAsIE1JUFNfQ1BVX0lTQV9JLCBNSVBTX0NQVV9UTEIsIDMyLAoJCXswLCAwLCAw
LCAwfSwgezAsIDAsIDAsIE1JUFNfQ0FDSEVfTkVFRFNfQ09ORklHfSwgCgkJezAsMCwwLDB9LCB7
MCwwLDAsMH19LAoJLyogUjMwMDBBICovCgl7IFBSSURfSU1QX1IzMDAwIHwgUFJJRF9SRVZfUjMw
MDBBLCBDUFVfUjMwMDBBLCAKCQlNSVBTX0NQVV9JU0FfSSwgTUlQU19DUFVfVExCLCAzMiwKCQl7
MCwgMCwgMCwgMH0sIHswLCAwLCAwLCBNSVBTX0NBQ0hFX05FRURTX0NPTkZJR30sIAoJCXswLDAs
MCwwfSwgezAsMCwwLDB9fSwKCS8qIFI2MDAwICovCgl7IFBSSURfSU1QX1I2MDAwLCBDUFVfUjYw
MDAsIE1JUFNfQ1BVX0lTQV9JSSwgCgkJTUlQU19DUFVfVExCIHwgTUlQU19DUFVfRlBVLCAzMiwK
CQl7MCwgMCwgMCwgMH0sIHswLCAwLCAwLCBNSVBTX0NBQ0hFX05FRURTX0NPTkZJR30sIAoJCXsw
LDAsMCwwfSwgezAsMCwwLDB9fSwKCS8qIFI2MDAwQSAqLwoJeyBQUklEX0lNUF9SNjAwMEEsIENQ
VV9SNjAwMEEsIE1JUFNfQ1BVX0lTQV9JSSwgCgkJTUlQU19DUFVfVExCIHwgTUlQU19DUFVfRlBV
LCAzMiwKCQl7MCwgMCwgMCwgMH0sIHswLCAwLCAwLCBNSVBTX0NBQ0hFX05FRURTX0NPTkZJR30s
IAoJCXswLDAsMCwwfSwgezAsMCwwLDB9fSwKCS8qIFI0MDAwU0MgKi8KCXsgUFJJRF9JTVBfUjQw
MDAsIENQVV9SNDAwMFNDLCBNSVBTX0NQVV9JU0FfSUlJLCAKCSAgICBSNEtfT1BUUyB8IE1JUFNf
Q1BVX0ZQVSB8IE1JUFNfQ1BVXzMyRlBSIAoJICAgIHwgTUlQU19DUFVfV0FUQ0ggfCBNSVBTX0NQ
VV9WQ0UsIDQ4LAoJCXswLCAwLCAxLCBNSVBTX0NBQ0hFX05FRURTX0NPTkZJR30sIAoJCXswLCAw
LCAxLCBNSVBTX0NBQ0hFX05FRURTX0NPTkZJR30sCgkJezAsMCwxLE1JUFNfQ0FDSEVfTkVFRFNf
Q09ORklHfSwgezAsMCwwLDB9fSwKCS8qIFI0NDAwU0MgKi8KCXsgUFJJRF9JTVBfUjQwMDAgfCBQ
UklEX1JFVl9SNDQwMCwgQ1BVX1I0NDAwU0MsIE1JUFNfQ1BVX0lTQV9JSUksIAoJICAgIFI0S19P
UFRTIHwgTUlQU19DUFVfRlBVIHwgTUlQU19DUFVfMzJGUFIgCgkgICAgfCBNSVBTX0NQVV9XQVRD
SCB8IE1JUFNfQ1BVX1ZDRSwgNDgsCgkJezAsIDAsIDEsIE1JUFNfQ0FDSEVfTkVFRFNfQ09ORklH
fSwgCgkJezAsIDAsIDEsIE1JUFNfQ0FDSEVfTkVFRFNfQ09ORklHfSwKCQl7MCwwLDEsIE1JUFNf
Q0FDSEVfTkVFRFNfQ09ORklHfSwgezAsMCwwLDB9fSwKCS8qIFI0MzAwICovCgl7IFBSSURfSU1Q
X1I0MzAwLCBDUFVfUjQzMDAsIE1JUFNfQ1BVX0lTQV9JSUksIAoJICAgIFI0S19PUFRTIHwgTUlQ
U19DUFVfRlBVIHwgTUlQU19DUFVfMzJGUFIgfCBNSVBTX0NQVV9XQVRDSCwgMzIsCgkJezMyLCA1
MTIsIDEsIE1JUFNfQ0FDSEVfTkVFRFNfQ09ORklHfSwgCgkJezE2LCA1MTIsIDEsIE1JUFNfQ0FD
SEVfTkVFRFNfQ09ORklHfSwgCgkJezAsMCwwLDB9LCB7MCwwLDAsMH19LAoJLyogUjQ2MDAgKi8K
CXsgUFJJRF9JTVBfUjQ2MDAsIENQVV9SNDYwMCwgTUlQU19DUFVfSVNBX0lJSSwgCgkgICAgUjRL
X09QVFMgfCBNSVBTX0NQVV9GUFUsIDQ4LAoJCXszMiwgMTI4LCAyLCBNSVBTX0NBQ0hFX05FRURT
X0NPTkZJR30sIAoJCXszMiwgMTI4LCAyLCBNSVBTX0NBQ0hFX05FRURTX0NPTkZJR30sIAoJCXsw
LDAsMCwwfSwgezAsMCwwLDB9fSwKCS8qIFI0NjUwICovCgl7IFBSSURfSU1QX1I0NjUwLCBDUFVf
UjQ2NTAsIE1JUFNfQ1BVX0lTQV9JSUksIAoJICAgIFI0S19PUFRTIHwgTUlQU19DUFVfRlBVLCA0
OCwKCQl7MzIsIDEyOCwgMiwgTUlQU19DQUNIRV9ORUVEU19DT05GSUd9LCAKCQl7MzIsIDEyOCwg
MiwgTUlQU19DQUNIRV9ORUVEU19DT05GSUd9LCAKCQl7MCwwLDAsMH0sIHswLDAsMCwwfX0sCgkv
KiBSNDcwMCAqLwoJeyBQUklEX0lNUF9SNDcwMCwgQ1BVX1I0NzAwLCBNSVBTX0NQVV9JU0FfSUlJ
LCAKCSAgICBSNEtfT1BUUyB8IE1JUFNfQ1BVX0ZQVSB8IE1JUFNfQ1BVXzMyRlBSLCA0OCwKCQl7
MzIsIDI1NiwgMiwgTUlQU19DQUNIRV9ORUVEU19DT05GSUd9LCAKCQl7MzIsIDI1NiwgMiwgTUlQ
U19DQUNIRV9ORUVEU19DT05GSUd9LCAKCQl7MCwwLDAsMH0sIHswLDAsMCwwfX0sCgkvKiBSNTAw
MCAqLwoJeyBQUklEX0lNUF9SNTAwMCwgQ1BVX1I1MDAwLCBNSVBTX0NQVV9JU0FfSVYsIAoJICAg
IFI0S19PUFRTIHwgTUlQU19DUFVfRlBVIHwgTUlQU19DUFVfMzJGUFIsIDQ4LAoJCXszMiwgNTEy
LCAyLCBNSVBTX0NBQ0hFX05FRURTX0NPTkZJR30sIAoJCXszMiwgNTEyLCAyLCBNSVBTX0NBQ0hF
X05FRURTX0NPTkZJR30sCgkJezAsMCwwLE1JUFNfQ0FDSEVfTkVFRFNfQ09ORklHfSwgezAsMCww
LDB9fSwKCS8qIFI1Mnh4LiBDYWNoZSBzaXplIHZhcmllcyB3aXRoIHJldmlzaW9uICovCgl7IFBS
SURfSU1QX05FVkFEQSwgQ1BVX05FVkFEQSwgTUlQU19DUFVfSVNBX0lWLCAKCSAgICBSNEtfT1BU
UyB8IE1JUFNfQ1BVX0ZQVSB8IE1JUFNfQ1BVXzMyRlBSIHwgTUlQU19DUFVfRElWRUMsIDQ4LAoJ
CXswLCAwLCAyLCBNSVBTX0NBQ0hFX05FRURTX0NPTkZJR30sIHswLCAwLCAyLCBNSVBTX0NBQ0hF
X05FRURTX0NPTkZJR30sCgkJezAsMCwwLDB9LCB7MCwwLDAsMH19LAoJLyogUjgwMDAgLSBoYXMg
d2llcmQgVExCOiAzLXdheSB4IDEyOCAqLwoJeyBQUklEX0lNUF9SODAwMCwgQ1BVX1I4MDAwLCBN
SVBTX0NQVV9JU0FfSVYsIAoJICAgIE1JUFNfQ1BVX1RMQiB8IE1JUFNfQ1BVXzRLRVggfCBNSVBT
X0NQVV9GUFUgfCBNSVBTX0NQVV8zMkZQUiwgMzg0LAoJCXszMiwgNTEyLCAxLCBNSVBTX0NBQ0hF
X1ZJUlRVQUx9LCB7MzIsIDUxMiwgMSwgMH0sCgkJezAsMCwwLE1JUFNfQ0FDSEVfTkVFRFNfQ09O
RklHfSwgezAsMCwwLDB9fSwKCS8qIFIxMDAwMCAqLwoJeyBQUklEX0lNUF9SMTAwMDAsIENQVV9S
MTAwMDAsIE1JUFNfQ1BVX0lTQV9JViwgCgkgICAgTUlQU19DUFVfVExCIHwgTUlQU19DUFVfNEtF
WCB8IE1JUFNfQ1BVX0ZQVSAKCSAgICB8IE1JUFNfQ1BVXzMyRlBSIHwgTUlQU19DUFVfQ09VTlRF
UiB8IE1JUFNfQ1BVX1dBVENILCA2NCwKCQl7MzIsIDUxMiwgMiwgMH0sIHszMiwgNTEyLCAyLCAw
fSwgCgkJezAsMCwwLE1JUFNfQ0FDSEVfTkVFRFNfQ09ORklHfSwgezAsMCwwLDB9fSwKfTsKCi8q
CiAqIFRoaXMgZnVuY3Rpb24gaXMgcnVubmluZyBvbiB0aGUgYm9vdCBwcm9tIHN0YWNrLiBJdCBz
aG91bGQKICogbWluaW1pemUgdXNlIG9mIGR5bmFtaWMgdmFyaWFibGVzIGFuZCBjYWxsIGFuIGFi
c29sdXRlCiAqIG1pbmltdW0gb2Ygb3RoZXIgZnVuY3Rpb25zLgogKi8KCl9faW5pdGZ1bmModm9p
ZCBtaXBzX2NwdV9wcm9iZSh1bnNpZ25lZCBpbnQgcHJfaWQpKQp7CglpbnQgaTsKCiNpZmRlZiBD
T05GSUdfQ1BVX01JUFMzMgoJLyoKCSAqIElmIGhpZ2gtb3JkZXIgaGFsZndvcmQgbm9uLXplcm8s
IHVzZSBNSVBTMzIgbWVjaGFuaXNtCgkgKi8KCWlmKChwcl9pZCA+PiAxNikgIT0gMCkgewoJCW1p
cHMzMl9jcHVfcHJvYmUocHJfaWQpOwoJCXJldHVybjsKCX0KI2VuZGlmCgoJLyoKCSAqIElmIG9s
ZCBlbmNvZGluZyBzY2hlbWUgYW5kIENQVSBpbiB0YWJsZSwgZmluZCBhbmQgY29weS4KCSAqCgkg
KiBGaXJzdCB0cnkgZm9yIG1hdGNoIGluY2x1ZGluZyByZXZpc2lvbiBudW1iZXIKCSAqLwoKCWZv
cihpPTA7IG1pcHNfY3B1X3RlbXBsYXRlW2ldLnByb2Nlc3Nvcl9pZCAhPSAwOyBpKyspIHsKCQlp
ZihtaXBzX2NwdV90ZW1wbGF0ZVtpXS5wcm9jZXNzb3JfaWQgPT0gcHJfaWQpIHsKCQkJbWVtY3B5
KCZtaXBzX2NwdSwgJm1pcHNfY3B1X3RlbXBsYXRlW2ldLAoJCQkJc2l6ZW9mKHN0cnVjdCBtaXBz
X2NwdSkpOwoJCQlyZXR1cm47CgkJfQoJfQoKCS8qCgkgKiBUaGF0IGZhaWxpbmcsIGxvb2sgZm9y
IG1hdGNoIG9uIGltcGxlbWVudGF0aW9uIG9ubHkKCSAqLwoKCWZvcihpPTA7IG1pcHNfY3B1X3Rl
bXBsYXRlW2ldLnByb2Nlc3Nvcl9pZCAhPSAwOyBpKyspIHsKCQlpZigobWlwc19jcHVfdGVtcGxh
dGVbaV0ucHJvY2Vzc29yX2lkICYgUFJJRF9JTVBfVU5LTk9XTikKCQkgICAgPT0gKHByX2lkICYg
UFJJRF9JTVBfVU5LTk9XTikpIHsKCQkJbWVtY3B5KCZtaXBzX2NwdSwgJm1pcHNfY3B1X3RlbXBs
YXRlW2ldLAoJCQkJc2l6ZW9mKHN0cnVjdCBtaXBzX2NwdSkpOwoJCQlyZXR1cm47CgkJfQoJfQoK
CS8qCgkgKiBPdGhlcndpc2UgQ1BVIGlzIHVua25vd24gLSBhbGwgYmV0cyBhcmUgb2ZmCgkgKi8K
CgltaXBzX2NwdS5wcm9jZXNzb3JfaWQgPSBwcl9pZDsKCW1pcHNfY3B1LmNwdXR5cGUgPSBDUFVf
VU5LTk9XTjsKCW1pcHNfY3B1Lm9wdGlvbnMgPSAwOwoJbWlwc19jcHUuaWNhY2hlLmZsYWdzID0g
TUlQU19DQUNIRV9ORUVEU19DT05GSUc7CgltaXBzX2NwdS5kY2FjaGUuZmxhZ3MgPSBNSVBTX0NB
Q0hFX05FRURTX0NPTkZJRzsKCW1pcHNfY3B1LnNjYWNoZS5mbGFncyA9IE1JUFNfQ0FDSEVfTkVF
RFNfQ09ORklHOwoJcmV0dXJuOwp9Cgo=

------=_NextPart_000_0083_01BFFC6C.24323180--
