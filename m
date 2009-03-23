Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2009 01:46:38 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:50051 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S21366687AbZCWBqc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Mar 2009 01:46:32 +0000
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 33C0140022;
	Mon, 23 Mar 2009 02:46:23 +0100 (CET)
Received: from [192.168.10.105] (c-30bde555.035-105-73746f38.cust.bredbandsbolaget.se [85.229.189.48])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 0483A40019;
	Mon, 23 Mar 2009 02:46:23 +0100 (CET)
Cc:	"Kevin D. Kissell" <kevink@paralogos.com>,
	linux-mips@linux-mips.org
Message-Id: <6C19836D-11E7-4DC6-A387-33DE8911D887@lysator.liu.se>
From:	Markus Gothe <nietzsche@lysator.liu.se>
To:	Nils Faerber <nils.faerber@kernelconcepts.de>
In-Reply-To: <49C6E64D.6090006@kernelconcepts.de>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4--379935989"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Need help iterpreting reg-dump
Date:	Mon, 23 Mar 2009 02:46:25 +0100
References: <49C42A9B.5050103@kernelconcepts.de> <49C4C36B.7010606@paralogos.com> <49C6E64D.6090006@kernelconcepts.de>
X-Pgp-Agent: GPGMail 1.2.0 (v56)
X-Mailer: Apple Mail (2.930.3)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <nietzsche@lysator.liu.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nietzsche@lysator.liu.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4--379935989
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

As you can se the Read-Address (ra) is within do_ade(...). Try running  
a cross-gdb on the host and list the ra for pinpointing...

//Markus
On 23 Mar 2009, at 02:30, Nils Faerber wrote:

> Hallo Kevin!
>
> First of all many thanks for your thoughts and especially your
> explanations of some of the kernel's internals!
>
> Kevin D. Kissell schrieb:
> [...]
>> So, while I can't prove anything conclusive based on the dump  
>> below, it
>> suggests that the processor took a CP1 exception on an instruction  
>> that
>> was emulated as an FP branch, so that the branch delay slot  
>> instruction
>> had to be executed off the top of the stack in the delay slot  
>> emulation
>> code, but that something was screwed up so that the call to
>> do_dsemulret() in do_ade() returned zero, so the unaligned access
>> handling threw a signal instead of ignoring it.
>>
>> The diagnostic code probably hasn't been armed in years, but if you
>> #define DSEMUL_TRACE when the code in arch/mips/math-emu is built (or
>> just hack it into dsemul.h or dsemul.c), it would help confirm or  
>> deny
>> the hypothesis.
>
> I have added some more debug outputs to the code. I can confirm now
> defnitely that the dsemul path is run and the the SIGILL is the result
> of a dsemul_ret returning 0, also see the below extended dumps.
>
> The strange thing is the fault does not always occur and if it  
> occurs it
> does not always happen in the same place of the application. So I  
> assume
> that this is not a problem of the application itself deliberatley
> executing a certain instruction but rather a side effect of something
> different - like wrong caches. On the other hand again it is strange
> that only the dsemul path seems to be triggered.
>
> Could it be that the exception that is used for math emulation can  
> also
> have other causes in different CPU implementations? The JZ4730 has  
> some
> DSP alike SIMD instructions... but then again why can't it be traced  
> to
> a single instruction inside the application (i.e. rather seems to  
> happen
> randomly)?
>
>>         Regards,
>>         Kevin K.
> Cheers
>  nils faerber
>
> [42949414.060000] do_dsemulret: bad magics, insn=0x8c830004
> [42949414.080000] do_dsemulret: cannot access emuframe
> [42949414.080000] Cpu 0
> [42949414.090000] $ 0   : 00000000 10000400 00000000 00000000
> [42949414.090000] $ 4   : 8033e528 80000000 00000024 0041469c
> [42949414.100000] $ 8   : 10000401 1000001e 00000003 00000022
> [42949414.100000] $12   : 2ac9a200 2aca0000 ffffffff 00401820
> [42949414.110000] $16   : 14400022 87d45f30 ffffffff 00414660
> [42949414.110000] $20   : 00000000 00000000 00000000 2ac0fa18
> [42949414.120000] $24   : 00000047 00000000
> [42949414.130000] $28   : 87d44000 87d45ee8 00000000 80020bf0
> [42949414.130000] Hi    : 0000002c
> [42949414.130000] Lo    : 0003aac9
> [42949414.140000] epc   : 80034098 do_dsemulret+0x3c/0xf4     Not  
> tainted
> [42949414.140000] ra    : 80020bf0 do_ade+0x20/0x3c0
> [42949414.150000] Status: 10000403    KERNEL EXL IE
> [42949414.150000] Cause : 10800010
> [42949414.160000] BadVA : 14400026
> [42949414.160000] PrId  : 02d0024f (Ingenic JZRISC)
> [42949414.160000] Modules linked in:
> [42949414.170000] Process keylaunch (pid: 1222, threadinfo=87d44000,
> task=87d6e1
> 78)
> [42949414.180000] Stack : 87d6e178 802dca50 8c830004 30620002 87d45f30
> 0041bbe1
> 80020bf0 00414660
> [42949414.180000]         00414660 0041bbe1 ffffffff 00414660 00414660
> 0041bbe1
> ffffffff 00414660
> [42949414.190000]         80018fa0 80019120 004d8474 004d843c 004d844c
> 004d8a02
> ffffffff 00000000
> [42949414.200000]         00000000 10000400 2ae66754 00418690 0041bbd9
> 0041bbe1
> 00000024 0041469c
> [42949414.210000]         00000023 00414690 00000003 00000022 2ac9a200
> 2aca0000
> ffffffff 00401820
> [42949414.220000]         ...
> [42949414.220000] Call Trace:
> [42949414.230000] [<80034098>] do_dsemulret+0x3c/0xf4
> [42949414.230000] [<80020bf0>] do_ade+0x20/0x3c0
> [42949414.230000] [<80018fa0>] ret_from_exception+0x0/0x24
> [42949414.240000]
> [42949414.240000]
> [42949414.240000] Code: 1460002b  2484e528  00601021 <8e060004>  
> 8e070008
> 3c0480
> 34  00431025  2484e550  10400013
> [42949414.290000] do_dsemulret: cannot access emuframe
> [42949414.290000] Cpu 0
> [42949414.300000] $ 0   : 00000000 10000400 fffffff2 00000000
> [42949414.300000] $ 4   : 8033e528 80000000 00000024 0041469c
> [42949414.310000] $ 8   : 10000401 1000001e 00000003 00000022
> [42949414.310000] $12   : 2ac9a200 2aca0000 ffffffff 00401820
> [42949414.320000] $16   : 14400022 87d45f30 ffffffff 00414660
> [42949414.320000] $20   : 00000000 00000000 00000000 2ac0fa18
> [42949414.330000] $24   : 00000047 00000000
> [42949414.330000] $28   : 87d44000 87d45ee8 00000000 80020bf0
> [42949414.340000] Hi    : 0000002c
> [42949414.340000] Lo    : 0003aac9
> [42949414.350000] epc   : 8003409c do_dsemulret+0x40/0xf4     Not  
> tainted
> [42949414.350000] ra    : 80020bf0 do_ade+0x20/0x3c0
> [42949414.360000] Status: 10000403    KERNEL EXL IE
> [42949414.360000] Cause : 00800010
> [42949414.370000] BadVA : 1440002a
> [42949414.370000] PrId  : 02d0024f (Ingenic JZRISC)
> [42949414.370000] Modules linked in:
> [42949414.380000] Process keylaunch (pid: 1222, threadinfo=87d44000,
> task=87d6e1
> 78)
> [42949414.380000] Stack : 87d6e178 802dca50 8c830004 30620002 87d45f30
> 0041bbe1
> 80020bf0 00414660
> [42949414.390000]         00414660 0041bbe1 ffffffff 00414660 00414660
> 0041bbe1
> ffffffff 00414660
> [42949414.400000]         80018fa0 80019120 004d8474 004d843c 004d844c
> 004d8a02
> ffffffff 00000000
> [42949414.410000]         00000000 10000400 2ae66754 00418690 0041bbd9
> 0041bbe1
> 00000024 0041469c
> [42949414.420000]         00000023 00414690 00000003 00000022 2ac9a200
> 2aca0000
> ffffffff 00401820
> [42949414.430000]         ...
> [42949414.430000] Call Trace:
> [42949414.430000] [<8003409c>] do_dsemulret+0x40/0xf4
> [42949414.440000] [<80020bf0>] do_ade+0x20/0x3c0
> [42949414.440000] [<80018fa0>] ret_from_exception+0x0/0x24
> [42949414.450000]
> [42949414.450000]
> [42949414.450000] Code: 2484e528  00601021  8e060004 <8e070008>  
> 3c048034
> 004310
> 25  2484e550  10400013  00c02821
> [42949414.550000] do_dsemulret: bad magics, insn=0x00000024
> [42949414.560000] do_dsemulret: cannot access emuframe
> [42949414.560000] Cpu 0
> [42949414.560000] $ 0   : 00000000 10000400 00000000 803bf8d0
> [42949414.570000] $ 4   : 8037c3d0 87d9fefc 00000005 00000005
> [42949414.570000] $ 8   : ebd8a1cf 00000005 feced300 ffffffff
> [42949414.580000] $12   : ec71384f 00000005 ffffffff 803bfd88
> [42949414.590000] $16   : 14400022 87d45f30 ffffffff 00414660
> [42949414.590000] $20   : 00000000 00000000 00000000 2ac0fa18
> [42949414.600000] $24   : 00000001 803bfda8
> [42949414.600000] $28   : 87d44000 87d45ee8 00000000 800340bc
> [42949414.610000] Hi    : 00989643
> [42949414.610000] Lo    : d5905180
> [42949414.610000] epc   : 800340d4 do_dsemulret+0x78/0xf4     Not  
> tainted
> [42949414.620000] ra    : 800340bc do_dsemulret+0x60/0xf4
> [42949414.630000] Status: 10000403    KERNEL EXL IE
> [42949414.630000] Cause : 20800010
> [42949414.630000] BadVA : 1440002e
> [42949414.640000] PrId  : 02d0024f (Ingenic JZRISC)
> [42949414.640000] Modules linked in:
> [42949414.650000] Process keylaunch (pid: 1222, threadinfo=87d44000,
> task=87d6e1
> 78)
> [42949414.650000] Stack : 87d6e178 00000024 00000024 0041469c 87d45f30
> 0041bbe1
> 80020bf0 00414660
> [42949414.660000]         00414660 0041bbe1 ffffffff 00414660 00414660
> 0041bbe1
> ffffffff 00414660
> [42949414.670000]         80018fa0 80019120 004d8474 004d843c 004d844c
> 004d8a02
> ffffffff 00000000
> [42949414.680000]         00000000 10000400 2ae66754 00418690 0041bbd9
> 0041bbe1
> 00000024 0041469c
> [42949414.690000]         00000023 00414690 00000003 00000022 2ac9a200
> 2aca0000
> ffffffff 00401820
> [42949414.700000]         ...
> [42949414.700000] Call Trace:
> [42949414.700000] [<800340d4>] do_dsemulret+0x78/0xf4
> [42949414.710000] [<80020bf0>] do_ade+0x20/0x3c0
> [42949414.710000] [<80018fa0>] ret_from_exception+0x0/0x24
> [42949414.720000]
> [42949414.720000]
> [42949414.720000] Code: 24420001  ac620014  00001021 <8e03000c>  
> 14400010
> 240400
> 0a  ae2300ac  24020001  8fbf0018
> [42949416.460000] do_dsemulret: bad magics, insn=0x8c830004
> [42949416.460000] do_dsemulret: cannot access emuframe
> [42949416.470000] Cpu 0
> [42949416.470000] $ 0   : 00000000 10000400 00000000 00000000
> [42949416.480000] $ 4   : 8033e528 80000000 00425c90 00000019
> [42949416.480000] $ 8   : 10000401 1000001e 36384658 72617453
> [42949416.490000] $12   : 87d744c0 00000000 87d744c0 00000000
> [42949416.490000] $16   : 14400022 87b0bf30 00414008 0000003f
> [42949416.500000] $20   : 00425c90 00400000 00400000 00000000
> [42949416.500000] $24   : 00000003 00000000
> [42949416.510000] $28   : 87b0a000 87b0bee8 2ae64858 80020bf0
> [42949416.520000] Hi    : 307e68e8
> [42949416.520000] Lo    : e1cb4540
> [42949416.520000] epc   : 80034098 do_dsemulret+0x3c/0xf4     Not  
> tainted
> [42949416.530000] ra    : 80020bf0 do_ade+0x20/0x3c0
> [42949416.530000] Status: 10000403    KERNEL EXL IE
> [42949416.540000] Cause : 10800010
> [42949416.540000] BadVA : 14400026
> [42949416.540000] PrId  : 02d0024f (Ingenic JZRISC)
> [42949416.550000] Modules linked in:
> [42949416.550000] Process keylaunch (pid: 1274, threadinfo=87b0a000,
> task=87daed
> f8)
> [42949416.560000] Stack : 87daedf8 802dca50 8c830004 30620002 87b0bf30
> 0041bbd9
> 80020bf0 0000003f
> [42949416.570000]         00425c94 0041bbd9 00414008 0000003f 00425c94
> 0041bbd9
> 00414008 0000003f
> [42949416.580000]         80018fa0 80019120 004d928c 004d8e44 004d9254
> 004daa9c
> ffffffff 00000000
> [42949416.590000]         00000000 10000400 2ae66754 00000001 0041bbd1
> 00000001
> 00425c90 00000019
> [42949416.600000]         ffffffff ffffffff 36384658 72617453 87d744c0
> 00000000
> 87d744c0 00000000
> [42949416.600000]         ...
> [42949416.610000] Call Trace:
> [42949416.610000] [<80034098>] do_dsemulret+0x3c/0xf4
> [42949416.610000] [<80020bf0>] do_ade+0x20/0x3c0
> [42949416.620000] [<80018fa0>] ret_from_exception+0x0/0x24
> [42949416.620000]
> [42949416.630000]
> [42949416.630000] Code: 1460002b  2484e528  00601021 <8e060004>  
> 8e070008
> 3c0480
> 34  00431025  2484e550  10400013
> [42949417.210000] do_dsemulret: bad magics, insn=0xaca20000
> [42949417.970000] do_dsemulret: cannot access emuframe
> [42949417.970000] Cpu 0
> [42949417.980000] $ 0   : 00000000 10000400 fffffff2 00000000
> [42949417.980000] $ 4   : 8033e528 80000000 00425c90 00000019
> [42949417.990000] $ 8   : 10000401 1000001e 36384658 72617453
> [42949417.990000] $12   : 87d744c0 00000000 87d744c0 00000000
> [42949418.000000] $16   : 14400022 87b0bf30 00414008 0000003f
> [42949418.000000] $20   : 00425c90 00400000 00400000 00000000
> [42949418.010000] $24   : 00000003 00000000
> [42949418.020000] $28   : 87b0a000 87b0bee8 2ae64858 80020bf0
> [42949418.020000] Hi    : 307e68e8
> [42949418.020000] Lo    : e1cb4540
> [42949418.030000] epc   : 8003409c do_dsemulret+0x40/0xf4     Not  
> tainted
> [42949418.030000] ra    : 80020bf0 do_ade+0x20/0x3c0
> [42949418.040000] Status: 10000403    KERNEL EXL IE
> [42949418.040000] Cause : 00800010
> [42949418.050000] BadVA : 1440002a
> [42949418.050000] PrId  : 02d0024f (Ingenic JZRISC)
> [42949418.060000] Modules linked in:
> [42949418.060000] Process keylaunch (pid: 1274, threadinfo=87b0a000,
> task=87daed
> f8)
> [42949418.070000] Stack : 87daedf8 802dca50 8c830004 30620002 87b0bf30
> 0041bbd9
> 80020bf0 0000003f
> [42949418.070000]         00425c94 0041bbd9 00414008 0000003f 00425c94
> 0041bbd9
> 00414008 0000003f
> [42949418.080000]         80018fa0 80019120 004d928c 004d8e44 004d9254
> 004daa9c
> ffffffff 00000000
> [42949418.090000]         00000000 10000400 2ae66754 00000001 0041bbd1
> 00000001
> 00425c90 00000019
> [42949418.100000]         ffffffff ffffffff 36384658 72617453 87d744c0
> 00000000
> 87d744c0 00000000
> [42949418.110000]         ...
> [42949418.110000] Call Trace:
> [42949418.120000] [<8003409c>] do_dsemulret+0x40/0xf4
> [42949418.120000] [<80020bf0>] do_ade+0x20/0x3c0
> [42949418.120000] [<80018fa0>] ret_from_exception+0x0/0x24
> [42949418.130000]
> [42949418.130000]
> [42949418.130000] Code: 2484e528  00601021  8e060004 <8e070008>  
> 3c048034
> 004310
> 25  2484e550  10400013  00c02821
> [42949419.210000] do_dsemulret: bad magics, insn=0x00425c90
> [42949419.210000] do_dsemulret: cannot access emuframe
> [42949419.220000] Cpu 0
> [42949419.220000] $ 0   : 00000000 10000400 00000000 803bf8d0
> [42949419.220000] $ 4   : 8037c3d0 87d9fefc 00000006 00000000
> [42949419.230000] $ 8   : 3c317acd 00000006 feced300 ffffffff
> [42949419.230000] $12   : 3cca114d 00000006 ffffffff 803bfd88
> [42949419.240000] $16   : 14400022 87b0bf30 00414008 0000003f
> [42949419.250000] $20   : 00425c90 00400000 00400000 00000000
> [42949419.250000] $24   : 00000001 803bfda8
> [42949419.260000] $28   : 87b0a000 87b0bee8 2ae64858 800340bc
> [42949419.260000] Hi    : 00989644
> [42949419.270000] Lo    : eb524680
> [42949419.270000] epc   : 800340d4 do_dsemulret+0x78/0xf4     Not  
> tainted
> [42949419.280000] ra    : 800340bc do_dsemulret+0x60/0xf4
> [42949419.280000] Status: 10000403    KERNEL EXL IE
> [42949419.290000] Cause : 20800010
> [42949419.290000] BadVA : 1440002e
> [42949419.290000] PrId  : 02d0024f (Ingenic JZRISC)
> [42949419.300000] Modules linked in:
> [42949419.300000] Process keylaunch (pid: 1274, threadinfo=87b0a000,
> task=87daed
> f8)
> [42949419.310000] Stack : 87daedf8 00425c90 00425c90 00000019 87b0bf30
> 0041bbd9
> 80020bf0 0000003f
> [42949419.320000]         00425c94 0041bbd9 00414008 0000003f 00425c94
> 0041bbd9
> 00414008 0000003f
> [42949419.320000]         80018fa0 80019120 004d928c 004d8e44 004d9254
> 004daa9c
> ffffffff 00000000
> [42949419.330000]         00000000 10000400 2ae66754 00000001 0041bbd1
> 00000001
> 00425c90 00000019
> [42949419.340000]         ffffffff ffffffff 36384658 72617453 87d744c0
> 00000000
> 87d744c0 00000000
> [42949419.350000]         ...
> [42949419.350000] Call Trace:
> [42949419.360000] [<800340d4>] do_dsemulret+0x78/0xf4
> [42949419.360000] [<80020bf0>] do_ade+0x20/0x3c0
> [42949419.370000] [<80018fa0>] ret_from_exception+0x0/0x24
> [42949419.370000]
> [42949419.370000]
> [42949419.370000] Code: 24420001  ac620014  00001021 <8e03000c>  
> 14400010
> 240400
> 0a  ae2300ac  24020001  8fbf0018
>
> -- 
> kernel concepts GbR      Tel: +49-271-771091-12
> Sieghuetter Hauptweg 48  Fax: +49-271-771091-19
> D-57072 Siegen           Mob: +49-176-21024535
> --
>


--Apple-Mail-4--379935989
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAknG6fEACgkQ6I0XmJx2NrwQJQCgqlls+zeutjX6PXndc4USIYph
h+AAoMi8mHdNOrm48SNlRqgHKjBq0BT+
=Yca9
-----END PGP SIGNATURE-----

--Apple-Mail-4--379935989--
