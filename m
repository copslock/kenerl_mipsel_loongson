Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 02:35:05 +0000 (GMT)
Received: from eta.ghs.com ([IPv6:::ffff:63.102.70.66]:44004 "EHLO eta.ghs.com")
	by linux-mips.org with ESMTP id <S8225353AbUAMCfE>;
	Tue, 13 Jan 2004 02:35:04 +0000
Received: from blaze.ghs.com (blaze.ghs.com [192.67.158.233])
	by eta.ghs.com (8.12.10/8.12.10) with ESMTP id i0D2Yx6t017835
	for <linux-mips@linux-mips.org>; Mon, 12 Jan 2004 18:34:59 -0800 (PST)
Received: from zcar.ghs.com (zcar.ghs.com [192.67.158.60])
	by blaze.ghs.com (8.12.9/8.12.9) with ESMTP id i0D2Yw9w008107;
	Mon, 12 Jan 2004 18:34:58 -0800 (PST)
Date: Mon, 12 Jan 2004 18:34:57 -0800 (PST)
From: Nathan Field <ndf@ghs.com>
To: linux-mips@linux-mips.org
Subject: ptrace induced instruction cache bug?
Message-ID: <Pine.LNX.4.44.0401121806240.1969-300000@zcar.ghs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1136671902-820035827-1073961297=:1969"
Return-Path: <ndf@ghs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ndf@ghs.com
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1136671902-820035827-1073961297=:1969
Content-Type: TEXT/PLAIN; charset=US-ASCII

I'm writing a debugger that uses the Linux ptrace API for process control
and I think I've found a bug in ptrace in MIPS Linux. The specific
situation that breaks horribly with my debugger is quite complex, so I
wrote a little testbed to show the problem. The code and a sample Makefile
are attached. You can build the example for x86 or MIPS. I have some
things in there for PPC but I haven't ported it fully yet. Basically the
problem seems to be that writing a breakpoint (instruction 0xd), running 
to the breakpoint, replacing the breakpoint with the original instruction 
and then resuming sometimes results in the process halting on the same 
address, even though there isn't a breakpoint there anymore. If you resume 
again, or wait for a "while" after removing the breakpoint everything 
works fine. I believe the problem is probably linked to some sort of 
problem with the kernel not flushing the instruction cache, but that's 
just a guess.

I've encountered problems in ptrace like this with other architectures
before. If anyone wants to take my ptrace test code and make it part of
some kernel validation system please do. The code was whipped up fairly 
quickly so you might want to clean it up. I've verified that when it is 
run slowly enough it works fine.

I'd guess that this problem has been fixed in later versions of the 
kernel. If anyone can point me to a 2.4 release with this fixed I'd like 
to know about it. I tried building the cvs checkout but the build failed. 
It looks like I'll need a newer toolchain than the one I got from 
MontaVista[1].

I'm using a stock MontaVista distribution for the MIPS Malta 4Kc in big
endian mode, downloaded from their site a couple of days ago. I recompiled
the kernel with the arch/mips/configs/defconfig-malta, but haven't changed 
any options yet. Since that could be hard to classify here are some 
details about my system:

$ uname -a
Linux 192.67.158.75 2.4.17_mvl21 #8 Wed Jan 7 18:19:32 PST 2004 mips unknown

gcc version:
19) ./mips_fp_be-gcc -v
./mips_fp_be-gcc: Actual path = 
'/space1/opt/hardhat/previewkit/mips/fp_be/bin/'        Actual name = 
'mips_fp_be-gcc'
        Invoking 
/space1/opt/hardhat/previewkit/mips/fp_be/bin/../lib/gcc-lib/mips-hardhat-linux/2.95.3/mips_fp_be-gcc
Reading specs from 
/space1/opt/hardhat/previewkit/mips/fp_be/bin/../lib/gcc-lib/mips-hardhat-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release/MontaVista)

$ cat /proc/cpuinfo
processor               : 0
cpu model               : MIPS 4Kc V0.5
BogoMIPS                : 124.51
wait instruction        : no
microsecond timers      : yes
extra interrupt vector  : yes
hardware watchpoint     : yes
VCED exceptions         : not available
VCEI exceptions         : not available

	Any help would be greatly appreciated,

	nathan

[1] Here's the error I get building the linux-mips.org cvs kernel. I don't 
know why it's trying to build a ramfs component, I only have ext2, /proc, 
/dev/pts, NFS, and NFS as root enabled. I've also diabled ramdisk support 
(CONFIG_BLK_DEV_RAM):

make[1]: `arch/mips/kernel/offset.s' is up to date.
make[1]: `arch/mips/kernel/reg.s' is up to date.
  CHK     include/linux/compile.h
  AS      usr/initramfs_data.o
usr/initramfs_data.S: Assembler messages:
usr/initramfs_data.S:29: Error: Unknown pseudo-op:  `.incbin'
make[1]: *** [usr/initramfs_data.o] Error 1
make: *** [usr] Error 2



-- 
Nathan Field (ndf@ghs.com)			          All gone.

But the trouble with analogies is that analogies are like goldfish:
sometimes they have nothing to do with the topic at hand.
        -- Crispin (from a posting to the Bugtraq mailing list)

--1136671902-820035827-1073961297=:1969
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="simpledebugger.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0401121834570.1969@zcar.ghs.com>
Content-Description: 
Content-Disposition: attachment; filename="simpledebugger.c"

I2lmbmRlZiBUQVJHRVRfQVJDSA0KIyAgZXJyb3IgWW91IG11c3QgZGVmaW5l
IGEgVEFSR0VUX0FSQ0guDQojZW5kaWYNCg0KI2RlZmluZSBYODYgICAxDQoj
ZGVmaW5lIE1JUFMgIDINCiNkZWZpbmUgUFBDICAgMw0KDQojaWYoVEFSR0VU
X0FSQ0g9PVg4NikNCiMgIGRlZmluZSBORUVEX1RPX0FESlVTVF9BRlRFUl9C
UF9ISVQNCiMgIGRlZmluZSBCUkVBS1BPSU5UX0lOU1RSVUNUSU9OIDB4Y2MN
CiMgIGRlZmluZSBCUkVBS1BPSU5UX1NJWkUgMQ0KI2VsaWYoVEFSR0VUX0FS
Q0g9PU1JUFMpDQojICBkZWZpbmUgQlJFQUtQT0lOVF9JTlNUUlVDVElPTiAw
eDAwMDAwMDBkDQojICBkZWZpbmUgQlJFQUtQT0lOVF9TSVpFIDQNCiNlbGlm
KFRBUkdFVF9BUkNIPT1QUEMpDQojICBkZWZpbmUgQlJFQUtQT0lOVF9JTlNU
UlVDVElPTiAweDdmZTAwMDA4DQojICBkZWZpbmUgQlJFQUtQT0lOVF9TSVpF
IDQNCiNlbHNlDQojICBlcnJvciBVbnN1cHBvcnRlZCBhcmNoLg0KI2VuZGlm
DQoNCiNkZWZpbmUgSVRFUkFUSU9OUyAxMDANCg0KDQovKiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tICovDQoNCg0KI2RlZmluZSBTVUNDRVNTIDENCiNkZWZpbmUg
RkFJTFVSRSAwDQoNCg0KLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAqLw0KDQoN
CiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPHN0ZGludC5oPg0KI2lu
Y2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPGVycm5vLmg+DQojaW5jbHVk
ZSA8c2lnbmFsLmg+DQojaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQojaW5jbHVk
ZSA8c3lzL3dhaXQuaD4NCiNpbmNsdWRlIDxzeXMvc2VsZWN0Lmg+DQojaW5j
bHVkZSA8c3lzL3B0cmFjZS5oPg0KI2luY2x1ZGUgPGFzbS9wdHJhY2UuaD4N
Cg0KDQovKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovDQoNCg0Kc3RhdGljIHZv
aWQgZGVidWdnZWRQcm9ncmFtKCk7DQpzdGF0aWMgdm9pZCBwYXJlbnRQcm9j
ZXNzKGludCBwaWQpOw0Kc3RhdGljIHZvaWQgc3RhcnRUcmFjZShjaGFyICpw
cm9nbmFtZSk7DQoNCi8qIEZ1bmN0aW9ucyB3ZSBzZXQgYnJlYWtwb2ludHMg
b24uICovDQppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKTsNCnN0
YXRpYyBpbnQgZG9Tb21ldGhpbmdGdW5jKCk7DQpzdGF0aWMgaW50IGRvU29t
ZXRoaW5nRWxzZUZ1bmMoKTsNCg0KDQoNCi8qIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0gKi8NCg0KDQovKiogVGhpcyBwcm9ncmFtIGlzIGEgdGVzdCBiZWQgdG8g
ZmluZCBidWdzIGluIExpbnV4IHB0cmFjZQ0KICogaW1wbGVtZW50YXRpb25z
LiAgSXQgc3RhcnRzIGJ5IGZvcmtpbmcuIFRoZSBjaGlsZCBwcm9jZXNzIGRv
ZXMgYQ0KICogUFRSQUNFX1RSQUNFTUUgYW5kIHRoZW4gYW4gZXhlYyBvZiBp
dHNlbGYgd2l0aCBzcGVjaWFsDQogKiBhcmd1bWVudHMuIFdoZW4gaXQgc3Rh
cnRzIHVwIGFnYWluIGl0IHRoZW4gcnVucyB0aGUgZGVidWdnZWRQcm9ncmFt
DQogKiBmdW5jdGlvbi4gVGhlIHBhcmVudCBkb2VzIHNvbWUgZGVidWdnaW5n
IG9wZXJhdGlvbnMgdG8gdGVzdA0KICogcHRyYWNlLiAqLw0KaW50IG1haW4o
aW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCnsNCiAgICBpbnQgcGlkOw0KDQog
ICAgaWYoIChhcmdjID09IDIpICYmICFzdHJjbXAoInRyYWNlZF9wcm9ncmFt
IiwgYXJndlsxXSkgKSB7DQoJZGVidWdnZWRQcm9ncmFtKCk7DQoJZXhpdCgw
KTsNCiAgICB9IGVsc2UgaWYoYXJnYyAhPSAxKSB7DQoJZnByaW50ZihzdGRl
cnIsICJSdW4gdGhpcyBwcm9ncmFtIHdpdGggbm8gYXJndW1lbnRzLlxuIik7
DQoJZXhpdCgxKTsNCiAgICB9DQoNCiAgICBwaWQgPSBmb3JrKCk7DQoNCiAg
ICBpZihwaWQgPT0gMCkgew0KCXN0YXJ0VHJhY2UoYXJndlswXSk7DQoJLyog
U2hvdWxkIG5ldmVyIGdldCBoZXJlLiAqLw0KCWV4aXQoMSk7DQogICAgfSBl
bHNlIHsNCglmcHJpbnRmKHN0ZGVyciwgIkFkZHJlc3Mgb2Y6XHRtYWluXHRc
dFx0OiAweCV4XG4iLCAodWludDMyX3QpbWFpbik7DQoJZnByaW50ZihzdGRl
cnIsICJBZGRyZXNzIG9mOlx0ZG9Tb21ldGhpbmdGdW5jXHRcdDogMHgleFxu
IiwNCgkJKHVpbnQzMl90KWRvU29tZXRoaW5nRnVuYyk7DQoJZnByaW50Zihz
dGRlcnIsICJBZGRyZXNzIG9mOlx0ZG9Tb21ldGhpbmdFbHNlRnVuY1x0OiAw
eCV4XG4iLA0KCQkodWludDMyX3QpZG9Tb21ldGhpbmdFbHNlRnVuYyk7DQoN
CglwYXJlbnRQcm9jZXNzKHBpZCk7DQogICAgfQ0KDQogICAgcmV0dXJuIDA7
DQp9DQoNCg0KLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAqLw0KDQoNCnN0YXRp
YyBpbnQgc29tZV9udW1iZXIgPSAwOw0KDQovKiBTZXQgYSBicmVha3BvaW50
IG9uIHRoaXMgZnVuY3Rpb24uICovDQpzdGF0aWMgaW50IGRvU29tZXRoaW5n
RnVuYygpDQp7DQogICAgcmV0dXJuICsrc29tZV9udW1iZXI7DQp9DQoNCnN0
YXRpYyB2b2lkIGRvU3lzdGVtQ2FsbCgpDQp7DQogICAgLyogU2VsZWN0IHNl
ZW1zIGxpa2UgYSBnb29kIHN5c3RlbSBjYWxsIHRvIGRvLiAqLw0KICAgIHN0
cnVjdCB0aW1ldmFsIHRpbWVvdXQ7DQogICAgdGltZW91dC50dl9zZWMgPSAw
Ow0KICAgIHRpbWVvdXQudHZfdXNlYyA9IDE7DQogICAgc2VsZWN0KDAsIDAs
IDAsIDAsICZ0aW1lb3V0KTsNCn0NCg0KLyogU2V0IGJyZWFrcG9pbnQgb24g
dGhpcyBmdW5jdGlvbi4gKi8NCnN0YXRpYyBpbnQgZG9Tb21ldGhpbmdFbHNl
RnVuYygpDQp7DQogICAgcmV0dXJuICsrc29tZV9udW1iZXI7DQp9DQoNCi8q
IFRoaXMgaXMgdGhlICJtZWF0IiBvZiB0aGUgcHJvZ3JhbSB3aGljaCBnZXRz
IGRlYnVnZ2VkLiBTaW5jZSBJIHVzZQ0KICogYSBjb21iaW5hdGlvbiBvZiBQ
VFJBQ0VfQ09OVCBhbmQgUFRSQUNFX1NZU0NBTEwgaXQncyBpbXBvcnRhbnQg
dGhhdA0KICogdGhpcyBwcm9ncmFtIG9ubHkgZG8gc3lzdGVtIGNhbGxzIGlu
IHZlcnkgc3BlY2lmaWMgc2l0dWF0aW9ucywgaW4NCiAqIHBhcnRpY3VsYXIg
b25seSBiZXR3ZWVuIHRoZSB0d28gZG9Tb21ldGhpbmcqIGZ1bmN0aW9ucy4g
Ki8NCnN0YXRpYyB2b2lkIGRlYnVnZ2VkUHJvZ3JhbSgpDQp7DQogICAgaW50
IGk7DQogICAgZm9yKGk9MDsgaTxJVEVSQVRJT05TOyArK2kpIHsNCglkb1Nv
bWV0aGluZ0Z1bmMoKTsNCglwcmludGYoImRlYnVnZ2VkUHJvZ3JhbTogRG9p
bmcgaXRlcmF0aW9uICVkLlxuIiwgaSk7DQoJZG9TeXN0ZW1DYWxsKCk7DQoJ
ZG9Tb21ldGhpbmdFbHNlRnVuYygpOw0KICAgIH0NCiAgICBwcmludGYoImRl
YnVnZ2VkUHJvZ3JhbTogRmluaXNoZWQuXG4iKTsNCn0NCg0KDQovKiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tICovDQoNCg0Kdm9pZCBmYWlsdXJlKGNvbnN0IGNo
YXIgKm1zZykNCnsNCiAgICBmcHJpbnRmKHN0ZGVyciwgbXNnKTsNCiAgICBl
eGl0KDEpOw0KfQ0KDQpzdGF0aWMgdm9pZCBzdGFydFRyYWNlKGNoYXIgKnBy
b2duYW1lKQ0Kew0KICAgIGNoYXIgKmFyZ3ZbXSA9IHtwcm9nbmFtZSwgInRy
YWNlZF9wcm9ncmFtIiwgTlVMTH07DQogICAgcHRyYWNlKFBUUkFDRV9UUkFD
RU1FLCAwLCAwLCAwKTsNCiAgICBleGVjdihwcm9nbmFtZSwgYXJndik7DQog
ICAgcGVycm9yKCJDaGlsZCBmYWlsZWQgdG8gZXhlY3YiKTsNCn0NCg0KLyog
cHRyYWNlIHJlYWRzL3dyaXRlcyBpbiA0IGJ5dGUgYmxvY2tzLCBzbyB3ZSBu
ZWVkIHRvIGJlIGFsaWduZWQgdG8gNA0KICogYnl0ZSBib3VuZGFyaWVzLiAq
Lw0Kc3RhdGljIGludCBhZGRyQWxpZ25lZCh1aW50MzJfdCBhZGRyKQ0Kew0K
ICAgIGlmKCAoYWRkciAmIDMpID09IDApIHsNCglyZXR1cm4gU1VDQ0VTUzsN
CiAgICB9IGVsc2Ugew0KCXJldHVybiBGQUlMVVJFOw0KICAgIH0NCn0NCg0K
c3RhdGljIHVpbnQzMl90IHJlYWRQQyhpbnQgcGlkKQ0Kew0KI2lmKFRBUkdF
VF9BUkNIPT1YODYpDQogICAgdWludDMyX3QgclsxN107IC8qIDE3IHJlZ2lz
dGVycyBvbiB4ODYgKi8NCiAgICBpZihwdHJhY2UoUFRSQUNFX0dFVFJFR1Ms
IHBpZCwgMCwgKGNoYXIgKikmciwgMCkgPT0gMCkgew0KCXJldHVybiByWzEy
XTsNCiAgICB9DQojZWxzZQ0KICAgIC8qIGFzbS1taXBzL3B0cmFjZS5oIE1J
UFMgZ2l2ZXMgdXMgYSBQQyBkZWZpbmUgZm9yIHRoZSBvZmZzZXQuICovDQog
ICAgdWludDMyX3QgdmFsID0gcHRyYWNlKFBUUkFDRV9QRUVLVVNFUiwgcGlk
LCBQQywgMCwgMCk7DQogICAgaWYoICh2YWwgIT0gLTEpIHx8IChlcnJubyA9
PSAwKSApIHsNCglyZXR1cm4gdmFsOw0KICAgIH0NCiNlbmRpZg0KICAgIHBl
cnJvcigiRmFpbGVkIHRvIHJlYWQgUEMuXG4iKTsNCiAgICBleGl0KDEpOw0K
ICAgIHJldHVybiAweEZGRkZGRkZGOw0KfQ0KDQpzdGF0aWMgdm9pZCB3cml0
ZVBDKGludCBwaWQsIHVpbnQzMl90IG5ld3BjKQ0Kew0KI2lmKFRBUkdFVF9B
UkNIPT1YODYpDQogICAgdWludDMyX3QgclsxN107DQogICAgaWYocHRyYWNl
KFBUUkFDRV9HRVRSRUdTLCBwaWQsIDAsIChjaGFyKikmciwgMCkgIT0gMCkg
ew0KCWZhaWx1cmUoIlVuYWJsZSB0byBnZXQgcmVnaXN0ZXJzIHRvIHdyaXRl
IG5ldyBQQy5cbiIpOw0KICAgIH0NCiAgICByWzEyXSA9IG5ld3BjOw0KICAg
IGlmKHB0cmFjZShQVFJBQ0VfU0VUUkVHUywgcGlkLCAwLCAoY2hhciopJnIs
IDApICE9IDApIHsNCglmYWlsdXJlKCJGYWlsZWQgdG8gd3JpdGUgcmVnaXN0
ZXJzIHdoZW4gYWRqdXN0aW5nIFBDLlxuIik7DQogICAgfQ0KI2VsaWYoVEFS
R0VUX0FSQ0g9PU1JUFMpDQogICAgLyogYXNtLW1pcHMvcHRyYWNlLmggTUlQ
UyBnaXZlcyB1cyBhIFBDIGRlZmluZSBmb3IgdGhlIG9mZnNldC4gKi8NCiAg
ICBpZihwdHJhY2UoUFRSQUNFX1BPS0VVU0VSLCBwaWQsIFBDLCBuZXdwYywg
MCkgIT0gMCkgew0KCWZhaWx1cmUoIkZhaWxlZCB0byB3cml0ZSBQQy5cbiIp
Ow0KICAgIH0NCiNlbHNlDQojICBlcnJvciBVbnN1cHBvcnRlZCBhcmNoLg0K
I2VuZGlmDQp9DQoNCnN0YXRpYyB1aW50MzJfdCBhZGp1c3RGb3JCcChpbnQg
cGlkLCB1aW50MzJfdCBjdXJwYykNCnsNCiNpZmRlZiBORUVEX1RPX0FESlVT
VF9BRlRFUl9CUF9ISVQNCiAgICB1aW50MzJfdCBuZXdwYzsNCiAgICBpZihj
dXJwYyAtIEJSRUFLUE9JTlRfU0laRSA9PSAodWludDMyX3QpbWFpbikgew0K
CW5ld3BjID0gY3VycGMgLSBCUkVBS1BPSU5UX1NJWkU7DQogICAgfSBlbHNl
IGlmKGN1cnBjIC0gQlJFQUtQT0lOVF9TSVpFID09ICh1aW50MzJfdClkb1Nv
bWV0aGluZ0Z1bmMpIHsNCgluZXdwYyA9IGN1cnBjIC0gQlJFQUtQT0lOVF9T
SVpFOw0KICAgIH0gZWxzZSBpZihjdXJwYyAtIEJSRUFLUE9JTlRfU0laRSA9
PSAodWludDMyX3QpZG9Tb21ldGhpbmdFbHNlRnVuYykgew0KCW5ld3BjID0g
Y3VycGMgLSBCUkVBS1BPSU5UX1NJWkU7DQogICAgfSBlbHNlIHsNCglyZXR1
cm4gY3VycGM7DQogICAgfQ0KICAgIHdyaXRlUEMocGlkLCBuZXdwYyk7DQog
ICAgcmV0dXJuIG5ld3BjOw0KI2Vsc2UNCiAgICByZXR1cm4gY3VycGM7DQoj
ZW5kaWYNCn0NCg0Kc3RhdGljIGludCByZWFkV29yZChpbnQgcGlkLCB1aW50
MzJfdCBhbGlnbmVkX2FkZHIsIHVpbnQzMl90ICp2YWwpDQp7DQogICAgKnZh
bCA9IHB0cmFjZShQVFJBQ0VfUEVFS0RBVEEsIHBpZCwgYWxpZ25lZF9hZGRy
LCAwKTsNCiAgICBpZiggKCp2YWwgPT0gMHhGRkZGRkZGRikgJiYgKGVycm5v
ICE9IDApICkgew0KCS8qIFRoZSB2YWx1ZSBjb3VsZCBiZSAtMSwgc28gY2hl
Y2sgZXJybm8gdG8gc2VlIGlmIHRoZXJlIHdhcyBhDQoJICogZmFpbHVyZS4g
Ki8NCglyZXR1cm4gRkFJTFVSRTsNCiAgICB9IGVsc2Ugew0KCXJldHVybiBT
VUNDRVNTOw0KICAgIH0NCn0NCg0Kc3RhdGljIGludCB3cml0ZVdvcmQoaW50
IHBpZCwgdWludDMyX3QgYWxpZ25lZF9hZGRyLCB1aW50MzJfdCB2YWwpDQp7
DQogICAgaWYocHRyYWNlKFBUUkFDRV9QT0tFREFUQSwgcGlkLCBhbGlnbmVk
X2FkZHIsIHZhbCkgPT0gLTEpIHsNCglyZXR1cm4gRkFJTFVSRTsNCiAgICB9
IGVsc2Ugew0KCXJldHVybiBTVUNDRVNTOw0KICAgIH0NCn0NCg0KLyogU3dh
cCBhIHZhbHVlICgxIGJ5dGUgb3IgNCkgd2l0aCB0aGUgY3VycmVudCB2YWx1
ZSBpbiB0aGUgZ2l2ZW4NCiAqIGxvY2F0aW9uLiAgV29ya3Mgd2l0aCB1bmFs
aWduZWQgYWRkcmVzc2VzICh3aGljaCBzaG91bGQgb25seSBoYXBwZW4NCiAq
IG9uIHg4NikuICovDQpzdGF0aWMgaW50IHN3YXBNZW1vcnkoaW50IHBpZCwg
dWludDMyX3QgYWRkciwgaW50IHNpemUsDQoJCSAgICAgIHVpbnQzMl90IG5l
d192YWwsIHVpbnQzMl90ICpvbGRfdmFsKQ0Kew0KICAgIGlmKGFkZHJBbGln
bmVkKGFkZHIpKSB7DQoJLyogU2ltcGxlIGNhc2UsIDQgYnl0ZSwgYWxpZ25l
ZCBhZGRyZXNzLiAqLw0KCWlmKHJlYWRXb3JkKHBpZCwgYWRkciwgb2xkX3Zh
bCkgIT0gU1VDQ0VTUykNCgkgICAgZmFpbHVyZSgiRmFpbGVkIHRvIHJlYWQg
d29yZCB3aGlsZSBzd2FwcGluZyBtZW1vcnkuXG4iKTsNCglzd2l0Y2goc2l6
ZSkgew0KCWNhc2UgMToNCiNpZmRlZiBMSVRUTEVfRU5ESUFODQoJICAgIG5l
d192YWwgPSAobmV3X3ZhbCAmIDB4MDAwMDAwRkYpIHwgKCpvbGRfdmFsICYg
MHhGRkZGRkYwMCk7DQoJICAgICpvbGRfdmFsID0gKm9sZF92YWwgJiAweDAw
MDAwMEZGOw0KI2Vsc2UgLyogYmlnIGVuZGlhbiBhcmNoICovDQogICAgICAg
ICAgICBuZXdfdmFsID0gKG5ld192YWwgPDwgMjQpIHwgKCpvbGRfdmFsICYg
MHgwMEZGRkZGRik7DQogICAgICAgICAgICAqb2xkX3ZhbCA9ICpvbGRfdmFs
ID4+IDI0Ow0KI2VuZGlmDQoJICAgIGJyZWFrOw0KCWNhc2UgNDoNCgkgICAg
YnJlYWs7DQoJZGVmYXVsdDoNCgkgICAgZmFpbHVyZSgiVW5zdXBwb3J0ZWQg
bWVtb3J5IHN3YXAgc2l6ZS5cbiIpOyANCgl9DQoJaWYod3JpdGVXb3JkKHBp
ZCwgYWRkciwgbmV3X3ZhbCkgIT0gU1VDQ0VTUykNCgkgICAgZmFpbHVyZSgi
RmFpbGVkIHRvIHdyaXRlIHdvcmQgd2hpbGUgc3dhcHBpbmcgbWVtb3J5Llxu
Iik7DQoJcmV0dXJuIFNVQ0NFU1M7DQogICAgfSBlbHNlIHsNCgkvLyBVbmFs
aWduZWQgYWRkcmVzcywgZG8gZWFjaCBieXRlIGluIHR1cm4gcmVjdXJzaXZs
eS4NCglpbnQgaTsNCgl1aW50MzJfdCBvbGRfcGFydGlhbDsNCglmb3IoaT0w
OyBpPHNpemU7ICsraSkgew0KCSAgICBvbGRfcGFydGlhbCA9IDA7DQoJICAg
IGlmKHN3YXBNZW1vcnkocGlkLCBhZGRyICsgKDIqaSksIDEsIG5ld192YWw8
PChpKjgpLCAmb2xkX3BhcnRpYWwpICE9IFNVQ0NFU1MpDQoJCWZhaWx1cmUo
IkZhaWxlZCB3aGlsZSBkb2luZyByZWN1cnNpdmUgc3dhcE1lbW9yeS5cbiIp
Ow0KCSAgICAqb2xkX3ZhbCA9ICpvbGRfdmFsICYgKG9sZF9wYXJ0aWFsIDw8
IChpKjgpKTsNCgl9DQoJcmV0dXJuIFNVQ0NFU1M7DQogICAgfQ0KfQ0KDQpz
dGF0aWMgdm9pZCBwYXJlbnRQcm9jZXNzKGludCBwaWQpDQp7DQogICAgaW50
IGk7DQogICAgaW50IHJldDsNCiAgICBpbnQgc3RhdHVzOw0KICAgIC8qIFVz
ZWQgdG8gc3RvcmUgaW5zdHJ1Y3Rpb24gd2hlcmUgdGhlIGJyZWFrcG9pbnQg
d2FzDQogICAgICogaW5zdGFsbGVkLiAqLw0KICAgIHVpbnQzMl90IGluc3Q7
DQogICAgdWludDMyX3QgdGVtcDsNCg0KICAgIHByaW50ZigicGFyZW50UHJv
Y2VzczogQmVnaW5uaW5nIGRlYnVnZ2luZyBvZiBjaGlsZCAlZC5cbiIsIHBp
ZCk7DQoNCiAgICAvKiBXYWl0IGZvciBwcm9jZXNzIHRvIGV4ZWMsIHdlIHdp
bGwgZ2V0IGEgU0lHVFJBUA0KICAgICAqIG5vdGlmaWNhdGlvbi4gKi8NCiAg
ICByZXQgPSB3YWl0cGlkKHBpZCwgJnN0YXR1cywgMCk7DQogICAgaWYocmV0
ICE9IHBpZCkgZmFpbHVyZSgid2FpdHBpZCB0byBmaW5kIGV4ZWMgZmFpbGVk
LlxuIik7DQoNCiAgICBpZighV0lGU1RPUFBFRChzdGF0dXMpIHx8IChXU1RP
UFNJRyhzdGF0dXMpICE9IFNJR1RSQVApKQ0KCWZhaWx1cmUoIkRpZCBub3Qg
Z2V0IGV4cGVjdGVkIFNJR1RSQVAgZm9yIGV4ZWMuXG4iKTsNCg0KICAgIC8q
IFNldCBicmVha3BvaW50IG9uIG1haW4uICovDQogICAgaWYoc3dhcE1lbW9y
eShwaWQsICh1aW50MzJfdCltYWluLCBCUkVBS1BPSU5UX1NJWkUsDQoJCSAg
QlJFQUtQT0lOVF9JTlNUUlVDVElPTiwgJmluc3QpICE9IFNVQ0NFU1MpDQoJ
ZmFpbHVyZSgiRmFpbGVkIHRvIGluc3RhbGwgYnJlYWtwb2ludCBvbiBtYWlu
LlxuIik7DQoNCiAgICAvKiBSZXN1bWUgcHJvY2Vzcy4gKi8NCiAgICBwdHJh
Y2UoUFRSQUNFX0NPTlQsIHBpZCwgMCwgMCk7DQoNCiAgICAvKiBXYWl0IGZv
ciBwcm9jZXNzIHRvIGhpdCBicmVha3BvaW50LCB3ZSB3aWxsIGdldCBhIFNJ
R1RSQVANCiAgICAgKiBub3RpZmljYXRpb24uICovDQogICAgcmV0ID0gd2Fp
dHBpZChwaWQsICZzdGF0dXMsIDApOw0KDQogICAgaWYoIVdJRlNUT1BQRUQo
c3RhdHVzKSkgew0KCWZhaWx1cmUoIlN0YXR1cyBpbmRpY2F0ZXMgdGhhdCBw
cm9jZXNzIGlzIG5vdCBzdG9wcGVkIG9uIG1haW4uXG4iKTsNCiAgICB9DQoN
CiAgICBpZihXU1RPUFNJRyhzdGF0dXMpICE9IFNJR1RSQVApIHsNCglmcHJp
bnRmKHN0ZGVyciwgIkZhaWx1cmUgYXR0ZW1wdGluZyB0byBoaXQgbWFpbi5c
biIpOw0KCWZwcmludGYoc3RkZXJyLCAiRGlkIG5vdCBnZXQgU0lHVFJBUCwg
Z290OiAlZC5cbiIsIFdTVE9QU0lHKHN0YXR1cykpOw0KCWZwcmludGYoc3Rk
ZXJyLCAiQ3VycmVudCBQQyBpczogMHgleC5cbiIsIHJlYWRQQyhwaWQpKTsN
CglleGl0KDEpOw0KICAgIH0NCg0KICAgIC8qIE1ha2Ugc3VyZSB3ZSBzdG9w
cGVkIG9uIHRoZSBicmVha3BvaW50LiAqLw0KICAgIGlmKGFkanVzdEZvckJw
KHBpZCwgcmVhZFBDKHBpZCkpICE9ICh1aW50MzJfdCltYWluKSB7DQoJZmFp
bHVyZSgiRGlkIG5vdCBzdG9wIG9uIG1haW4uXG4iKTsNCiAgICB9DQoNCiAg
ICAvKiBSZW1vdmUgYnJlYWtwb2ludCBvbiBtYWluLiAqLw0KICAgIGlmKHN3
YXBNZW1vcnkocGlkLCAodWludDMyX3QpbWFpbiwgQlJFQUtQT0lOVF9TSVpF
LA0KCQkgIGluc3QsICZ0ZW1wKSAhPSBTVUNDRVNTKQ0KCWZhaWx1cmUoIkZh
aWxlZCB0byByZW1vdmUgYnJlYWtwb2ludCBvbiBtYWluLlxuIik7DQoNCiAg
ICBmb3IoaT0wOyBpPElURVJBVElPTlM7ICsraSkgew0KCS8qIFNldCBicmVh
a3BvaW50IG9uIGRvU29tZXRoaW5nRnVuYy4gKi8NCglpZihzd2FwTWVtb3J5
KHBpZCwgKHVpbnQzMl90KWRvU29tZXRoaW5nRnVuYywgQlJFQUtQT0lOVF9T
SVpFLA0KCQkgICAgICBCUkVBS1BPSU5UX0lOU1RSVUNUSU9OLCAmaW5zdCkg
IT0gU1VDQ0VTUykNCgkgICAgZmFpbHVyZSgiRmFpbGVkIHRvIGluc3RhbGwg
YnJlYWtwb2ludCBvbiBkb1NvbWV0aGluZ0Z1bmMuXG4iKTsNCg0KCS8qIFJl
c3VtZSBwcm9jZXNzLiAqLw0KCXB0cmFjZShQVFJBQ0VfU1lTQ0FMTCwgcGlk
LCAwLCAwKTsNCg0KCS8qIFdhaXQgZm9yIHByb2Nlc3MgdG8gaGl0IGJyZWFr
cG9pbnQsIHdlIHdpbGwgZ2V0IGEgU0lHVFJBUA0KCSAqIG5vdGlmaWNhdGlv
bi4gKi8NCglyZXQgPSB3YWl0cGlkKHBpZCwgJnN0YXR1cywgMCk7DQoNCglp
ZighV0lGU1RPUFBFRChzdGF0dXMpIHx8IChXU1RPUFNJRyhzdGF0dXMpICE9
IFNJR1RSQVApKQ0KCSAgICBmYWlsdXJlKCJEaWQgbm90IGdldCBleHBlY3Rl
ZCBTSUdUUkFQIGZvciBoaXR0aW5nIGJyZWFrcG9pbnQuXG4iKTsNCg0KCWlm
KCFXSUZTVE9QUEVEKHN0YXR1cykpIHsNCgkgICAgZmFpbHVyZSgiU3RhdHVz
IGluZGljYXRlcyB0aGF0IHByb2Nlc3MgaXMgbm90IHN0b3BwZWQuXG4iKTsN
Cgl9DQoNCglpZihXU1RPUFNJRyhzdGF0dXMpICE9IFNJR1RSQVApIHsNCgkg
ICAgZnByaW50ZihzdGRlcnIsICJGYWlsdXJlIGF0dGVtcHRpbmcgdG8gaGl0
IGRvU29tZXRoaW5nRnVuYy5cbiIpOw0KCSAgICBmcHJpbnRmKHN0ZGVyciwg
IkRpZCBub3QgZ2V0IGV4cGVjdGVkIFNJR1RSQVAsIGdvdDogJWQuXG4iLCBX
U1RPUFNJRyhzdGF0dXMpKTsNCgkgICAgZnByaW50ZihzdGRlcnIsICJDdXJy
ZW50IFBDIGlzOiAweCV4LlxuIiwgcmVhZFBDKHBpZCkpOw0KCSAgICBleGl0
KDEpOw0KCX0NCg0KCS8qIE1ha2Ugc3VyZSB3ZSBzdG9wcGVkIG9uIHRoZSBi
cmVha3BvaW50LiAqLw0KCWlmKGFkanVzdEZvckJwKHBpZCwgcmVhZFBDKHBp
ZCkpICE9ICh1aW50MzJfdClkb1NvbWV0aGluZ0Z1bmMpIHsNCgkgICAgZnBy
aW50ZihzdGRlcnIsICJQQyBpcyBub3QgMHgleCwgaXQgaXM6IDB4JXguXG4i
LCAodWludDMyX3QpZG9Tb21ldGhpbmdGdW5jLA0KCQkgICAgcmVhZFBDKHBp
ZCkpOw0KCSAgICBmYWlsdXJlKCJEaWQgbm90IHN0b3Agb24gZG9Tb21ldGhp
bmdGdW5jLlxuIik7DQoJfQ0KDQoJLyogUmVtb3ZlIGJyZWFrcG9pbnQgb24g
ZG9Tb21ldGhpbmdGdW5jLiAqLw0KCWlmKHN3YXBNZW1vcnkocGlkLCAodWlu
dDMyX3QpZG9Tb21ldGhpbmdGdW5jLCBCUkVBS1BPSU5UX1NJWkUsDQoJCSAg
ICAgIGluc3QsICZ0ZW1wKSAhPSBTVUNDRVNTKQ0KCSAgICBmYWlsdXJlKCJG
YWlsZWQgdG8gcmVtb3ZlIGJyZWFrcG9pbnQgb24gZG9Tb21ldGhpbmdGdW5j
LlxuIik7DQoNCg0KCS8qIFNldCBicmVha3BvaW50IG9uIGRvU29tZXRoaW5n
RWxzZUZ1bmMuICovDQoJaWYoc3dhcE1lbW9yeShwaWQsICh1aW50MzJfdClk
b1NvbWV0aGluZ0Vsc2VGdW5jLCBCUkVBS1BPSU5UX1NJWkUsDQoJCSAgICAg
IEJSRUFLUE9JTlRfSU5TVFJVQ1RJT04sICZpbnN0KSAhPSBTVUNDRVNTKQ0K
CSAgICBmYWlsdXJlKCJGYWlsZWQgdG8gaW5zdGFsbCBicmVha3BvaW50IG9u
IGRvU29tZXRoaW5nRWxzZUZ1bmMuXG4iKTsNCg0KCS8qIFJlc3VtZSBwcm9j
ZXNzLiAqLw0KCXB0cmFjZShQVFJBQ0VfQ09OVCwgcGlkLCAwLCAwKTsNCg0K
CS8qIFdhaXQgZm9yIHByb2Nlc3MgdG8gaGl0IGJyZWFrcG9pbnQsIHdlIHdp
bGwgZ2V0IGEgU0lHVFJBUA0KCSAqIG5vdGlmaWNhdGlvbi4gKi8NCglyZXQg
PSB3YWl0cGlkKHBpZCwgJnN0YXR1cywgMCk7DQoNCglpZihyZXQgIT0gcGlk
KSB7DQoJICAgIGZhaWx1cmUoIlJldHVybiBmcm9tIHdhaXRwaWQgaW5kaWNh
dGVzIGVycm9yIG9yIHRoYXQgcHJvY2VzcyBpcyBzdGlsbCBydW5uaW5nLlxu
Iik7DQoJfQ0KDQoJaWYoIVdJRlNUT1BQRUQoc3RhdHVzKSkgew0KCSAgICBm
YWlsdXJlKCJTdGF0dXMgaW5kaWNhdGVzIHRoYXQgcHJvY2VzcyBpcyBub3Qg
c3RvcHBlZC5cbiIpOw0KCX0NCg0KCWlmKFdTVE9QU0lHKHN0YXR1cykgIT0g
U0lHVFJBUCkgew0KCSAgICBmcHJpbnRmKHN0ZGVyciwgIkZhaWx1cmUgYXR0
ZW1wdGluZyB0byBoaXQgZG9Tb21ldGhpbmdFbHNlRnVuYy5cbiIpOw0KCSAg
ICBmcHJpbnRmKHN0ZGVyciwgIkRpZCBub3QgZ2V0IGV4cGVjdGVkIFNJR1RS
QVAsIGdvdDogJWQuXG4iLCBXU1RPUFNJRyhzdGF0dXMpKTsNCgkgICAgZnBy
aW50ZihzdGRlcnIsICJDdXJyZW50IFBDIGlzOiAweCV4LlxuIiwgcmVhZFBD
KHBpZCkpOw0KCSAgICBleGl0KDEpOw0KCX0NCg0KCS8qIE1ha2Ugc3VyZSB3
ZSBzdG9wcGVkIG9uIHRoZSBicmVha3BvaW50LiAqLw0KCWlmKGFkanVzdEZv
ckJwKHBpZCwgcmVhZFBDKHBpZCkpICE9ICh1aW50MzJfdClkb1NvbWV0aGlu
Z0Vsc2VGdW5jKSB7DQoJICAgIGZwcmludGYoc3RkZXJyLCAiUEMgaXMgbm90
IDB4JXgsIGl0IGlzOiAweCV4LlxuIiwgKHVpbnQzMl90KWRvU29tZXRoaW5n
RWxzZUZ1bmMsDQoJCSAgICByZWFkUEMocGlkKSk7DQoJICAgIGZhaWx1cmUo
IkRpZCBub3Qgc3RvcCBvbiBkb1NvbWV0aGluZ0Vsc2VGdW5jLlxuIik7DQoJ
fQ0KDQoJLyogUmVtb3ZlIGJyZWFrcG9pbnQgb24gZG9Tb21ldGhpbmdFbHNl
RnVuYy4gKi8NCglpZihzd2FwTWVtb3J5KHBpZCwgKHVpbnQzMl90KWRvU29t
ZXRoaW5nRWxzZUZ1bmMsIEJSRUFLUE9JTlRfU0laRSwNCgkJICAgICAgaW5z
dCwgJnRlbXApICE9IFNVQ0NFU1MpDQoJICAgIGZhaWx1cmUoIkZhaWxlZCB0
byByZW1vdmUgYnJlYWtwb2ludCBvbiBkb1NvbWV0aGluZ0Vsc2VGdW5jLlxu
Iik7DQogICAgfQ0KDQogICAgLyogUmVzdW1lIHByb2Nlc3MgdG8gbGV0IGl0
IGNvbXBsZXRlLiAqLw0KICAgIHB0cmFjZShQVFJBQ0VfQ09OVCwgcGlkLCAw
LCAwKTsNCg0KICAgIHJldCA9IHdhaXRwaWQocGlkLCAmc3RhdHVzLCAwKTsN
Cg0KICAgIGlmKCFXSUZFWElURUQoc3RhdHVzKSkgew0KCWZhaWx1cmUoIkRl
YnVnZ2VkIHByb2dyYW0gZmFpbGVkIHRvIGV4aXQgYXQgZXhwZWN0ZWQgdGlt
ZS5cbiIpOw0KICAgIH0NCg0KICAgIHByaW50ZigicGFyZW50UHJvY2Vzczog
U2hvdWxkIGhhdmUgaGl0IGFsbCBicCdzLCBjaGlsZCBzaG91bGQgaGF2ZSBl
eGl0ZWQuXG4iKTsNCn0NCg==
--1136671902-820035827-1073961297=:1969
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=Makefile
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0401121834571.1969@zcar.ghs.com>
Content-Description: 
Content-Disposition: attachment; filename=Makefile

Q0NfTUFMVEFfRUI9L2hvbWUvemNhcjEvb3B0L2hhcmRoYXQvcHJldmlld2tp
dC9taXBzL2ZwX2JlL2Jpbi9taXBzX2ZwX2JlLWdjYw0KTUFMVEFfREVGSU5F
Uz0tRFRBUkdFVF9BUkNIPU1JUFMNCg0KDQpEQkxJTks9ZGJsaW5rIC0tc2Nh
bl9zb3VyY2UgLWF1dG9fdHJhbnNsYXRlIA0KDQpDRkxBR1M9LWcgLVdhbGwN
Cg0KDQoNClRBUkdFVFM9c2ltcGxlZGVidWdnZXJfbWFsdGFfZWINCg0KYWxs
OiAkKFRBUkdFVFMpDQoNCnNpbXBsZWRlYnVnZ2VyX21hbHRhX2ViOiBzaW1w
bGVkZWJ1Z2dlci5jDQoJJChDQ19NQUxUQV9FQikgJChNQUxUQV9ERUZJTkVT
KSAkKENGTEFHUykgLW8gJEAgJDwNCgkkKERCTElOSykgJEANCg0KY2xlYW46
DQoJcm0gLXJmICp+IGNvcmUqICoubyBvYmpzDQoNCmNsb2JiZXI6IGNsZWFu
DQoJcm0gLWYgJChUQVJHRVRTKSAkKFRBUkdFVFMpLioNCg==
--1136671902-820035827-1073961297=:1969--
