Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2009 07:26:01 +0000 (GMT)
Received: from gateway08.websitewelcome.com ([67.18.36.18]:32453 "HELO
	gateway08.websitewelcome.com") by ftp.linux-mips.org with SMTP
	id S21367012AbZCWHZq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Mar 2009 07:25:46 +0000
Received: (qmail 24246 invoked from network); 23 Mar 2009 07:26:24 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway08.websitewelcome.com with SMTP; 23 Mar 2009 07:26:24 -0000
Received: from [217.109.65.213] (port=1406 helo=[192.168.236.58])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LleXW-0005y0-Hu; Mon, 23 Mar 2009 02:25:43 -0500
Message-ID: <49C73976.10106@paralogos.com>
Date:	Mon, 23 Mar 2009 02:25:42 -0500
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Nils Faerber <nils.faerber@kernelconcepts.de>
CC:	linux-mips@linux-mips.org
Subject: Re: Need help iterpreting reg-dump
References: <49C42A9B.5050103@kernelconcepts.de> <49C4C36B.7010606@paralogos.com> <49C6E64D.6090006@kernelconcepts.de>
In-Reply-To: <49C6E64D.6090006@kernelconcepts.de>
Content-Type: multipart/alternative;
 boundary="------------030001090906030806010308"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030001090906030806010308
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Nils Faerber wrote:
>  
> I have added some more debug outputs to the code. I can confirm now
> defnitely that the dsemul path is run and the the SIGILL is the result
> of a dsemul_ret returning 0, also see the below extended dumps.
>   
Careful what you infer.  do_dsemulret() is *always* called on a 
misaligned address trap,
and *almost always* returns zero.  I suggested turning on DSEMUL_TRACE 
because
it would indicate whether the traps were those deliberately set, as I 
suspected they might be
based on the BadVA and EPC values in your initial crashdump.  Your 
diagnostic output
below simply shows that there were a number of misaligned accesses 
performed that
do *not* seem to have been associated with FPU emulator activity.

> The strange thing is the fault does not always occur and if it occurs it
> does not always happen in the same place of the application. So I assume
> that this is not a problem of the application itself deliberatley
> executing a certain instruction but rather a side effect of something
> different - like wrong caches. On the other hand again it is strange
> that only the dsemul path seems to be triggered.
>   
See the above.  Don't confuse dsemul with dsemulret.
> Could it be that the exception that is used for math emulation can also
> have other causes in different CPU implementations? The JZ4730 has some
> DSP alike SIMD instructions... but then again why can't it be traced to
> a single instruction inside the application (i.e. rather seems to happen
> randomly)?
>   
I suppose that's possible, but the trace information below suggests that 
there's something
else a bit funky going on.

It's an annoying property of the standard MIPS Linux configurations that 
misaligned accesses
by user mode code, which should never actually happen in correctly 
written and compiled code,
are silently worked-around by the kernel.  If DEBUG_FS is configured, 
then one at least gets
a count of how many times this has been done, but in general one just 
gets silently degraded
performance.  The dump below seems to indicate that the kernel silently 
(or, what would have
been silently) dealt with some misaligned operations on a data structure 
in the program data
segment (not on the stack).  But I'm not 100% sure how you generated it, 
so I can't be sure
what parts of it are valid and what are instrumentation noise.  These 
bad accesses *might*
have nothing whatsoever to do with your later SIGILLs.

          Regards,

          Kevin K.
> Cheers
>   nils faerber
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
> [42949414.140000] epc   : 80034098 do_dsemulret+0x3c/0xf4     Not tainted
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
> [42949414.240000] Code: 1460002b  2484e528  00601021 <8e060004> 8e070008
>  3c0480
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
> [42949414.350000] epc   : 8003409c do_dsemulret+0x40/0xf4     Not tainted
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
> [42949414.450000] Code: 2484e528  00601021  8e060004 <8e070008> 3c048034
>  004310
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
> [42949414.610000] epc   : 800340d4 do_dsemulret+0x78/0xf4     Not tainted
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
> [42949414.720000] Code: 24420001  ac620014  00001021 <8e03000c> 14400010
>  240400
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
> [42949416.520000] epc   : 80034098 do_dsemulret+0x3c/0xf4     Not tainted
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
> [42949416.630000] Code: 1460002b  2484e528  00601021 <8e060004> 8e070008
>  3c0480
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
> [42949418.030000] epc   : 8003409c do_dsemulret+0x40/0xf4     Not tainted
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
> [42949418.130000] Code: 2484e528  00601021  8e060004 <8e070008> 3c048034
>  004310
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
> [42949419.270000] epc   : 800340d4 do_dsemulret+0x78/0xf4     Not tainted
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
> [42949419.370000] Code: 24420001  ac620014  00001021 <8e03000c> 14400010
>  240400
> 0a  ae2300ac  24020001  8fbf0018
>
>   


--------------030001090906030806010308
Content-Type: text/html; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-15"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Nils Faerber wrote:
<blockquote cite="mid:49C6E64D.6090006@kernelconcepts.de" type="cite">
  <pre wrap=""> 
I have added some more debug outputs to the code. I can confirm now
defnitely that the dsemul path is run and the the SIGILL is the result
of a dsemul_ret returning 0, also see the below extended dumps.
  </pre>
</blockquote>
Careful what you infer.  do_dsemulret() is *always* called on a
misaligned address trap,<br>
and *almost always* returns zero.  I suggested turning on DSEMUL_TRACE
because<br>
it would indicate whether the traps were those deliberately set, as I
suspected they might be<br>
based on the BadVA and EPC values in your initial crashdump.  Your
diagnostic output<br>
below simply shows that there were a number of misaligned accesses
performed that<br>
do *not* seem to have been associated with FPU emulator activity.<br>
<br>
<blockquote cite="mid:49C6E64D.6090006@kernelconcepts.de" type="cite">
  <pre wrap="">
The strange thing is the fault does not always occur and if it occurs it
does not always happen in the same place of the application. So I assume
that this is not a problem of the application itself deliberatley
executing a certain instruction but rather a side effect of something
different - like wrong caches. On the other hand again it is strange
that only the dsemul path seems to be triggered.
  </pre>
</blockquote>
See the above.  Don't confuse dsemul with dsemulret.<br>
<blockquote cite="mid:49C6E64D.6090006@kernelconcepts.de" type="cite">
  <pre wrap="">
Could it be that the exception that is used for math emulation can also
have other causes in different CPU implementations? The JZ4730 has some
DSP alike SIMD instructions... but then again why can't it be traced to
a single instruction inside the application (i.e. rather seems to happen
randomly)?
  </pre>
</blockquote>
I suppose that's possible, but the trace information below suggests
that there's something<br>
else a bit funky going on.<br>
<br>
It's an annoying property of the standard MIPS Linux configurations
that misaligned accesses<br>
by user mode code, which should never actually happen in correctly
written and compiled code,<br>
are silently worked-around by the kernel.  If DEBUG_FS is configured,
then one at least gets<br>
a count of how many times this has been done, but in general one just
gets silently degraded<br>
performance.  The dump below seems to indicate that the kernel silently
(or, what would have<br>
been silently) dealt with some misaligned operations on a data
structure in the program data<br>
segment (not on the stack).  But I'm not 100% sure how you generated
it, so I can't be sure<br>
what parts of it are valid and what are instrumentation noise.  These
bad accesses *might*<br>
have nothing whatsoever to do with your later SIGILLs.<br>
<br>
          Regards,<br>
<br>
          Kevin K.<br>
<blockquote cite="mid:49C6E64D.6090006@kernelconcepts.de" type="cite">
  <pre wrap=""><!---->Cheers
  nils faerber

[42949414.060000] do_dsemulret: bad magics, insn=0x8c830004
[42949414.080000] do_dsemulret: cannot access emuframe
[42949414.080000] Cpu 0
[42949414.090000] $ 0   : 00000000 10000400 00000000 00000000
[42949414.090000] $ 4   : 8033e528 80000000 00000024 0041469c
[42949414.100000] $ 8   : 10000401 1000001e 00000003 00000022
[42949414.100000] $12   : 2ac9a200 2aca0000 ffffffff 00401820
[42949414.110000] $16   : 14400022 87d45f30 ffffffff 00414660
[42949414.110000] $20   : 00000000 00000000 00000000 2ac0fa18
[42949414.120000] $24   : 00000047 00000000
[42949414.130000] $28   : 87d44000 87d45ee8 00000000 80020bf0
[42949414.130000] Hi    : 0000002c
[42949414.130000] Lo    : 0003aac9
[42949414.140000] epc   : 80034098 do_dsemulret+0x3c/0xf4     Not tainted
[42949414.140000] ra    : 80020bf0 do_ade+0x20/0x3c0
[42949414.150000] Status: 10000403    KERNEL EXL IE
[42949414.150000] Cause : 10800010
[42949414.160000] BadVA : 14400026
[42949414.160000] PrId  : 02d0024f (Ingenic JZRISC)
[42949414.160000] Modules linked in:
[42949414.170000] Process keylaunch (pid: 1222, threadinfo=87d44000,
task=87d6e1
78)
[42949414.180000] Stack : 87d6e178 802dca50 8c830004 30620002 87d45f30
0041bbe1
80020bf0 00414660
[42949414.180000]         00414660 0041bbe1 ffffffff 00414660 00414660
0041bbe1
ffffffff 00414660
[42949414.190000]         80018fa0 80019120 004d8474 004d843c 004d844c
004d8a02
ffffffff 00000000
[42949414.200000]         00000000 10000400 2ae66754 00418690 0041bbd9
0041bbe1
00000024 0041469c
[42949414.210000]         00000023 00414690 00000003 00000022 2ac9a200
2aca0000
ffffffff 00401820
[42949414.220000]         ...
[42949414.220000] Call Trace:
[42949414.230000] [&lt;80034098&gt;] do_dsemulret+0x3c/0xf4
[42949414.230000] [&lt;80020bf0&gt;] do_ade+0x20/0x3c0
[42949414.230000] [&lt;80018fa0&gt;] ret_from_exception+0x0/0x24
[42949414.240000]
[42949414.240000]
[42949414.240000] Code: 1460002b  2484e528  00601021 &lt;8e060004&gt; 8e070008
 3c0480
34  00431025  2484e550  10400013
[42949414.290000] do_dsemulret: cannot access emuframe
[42949414.290000] Cpu 0
[42949414.300000] $ 0   : 00000000 10000400 fffffff2 00000000
[42949414.300000] $ 4   : 8033e528 80000000 00000024 0041469c
[42949414.310000] $ 8   : 10000401 1000001e 00000003 00000022
[42949414.310000] $12   : 2ac9a200 2aca0000 ffffffff 00401820
[42949414.320000] $16   : 14400022 87d45f30 ffffffff 00414660
[42949414.320000] $20   : 00000000 00000000 00000000 2ac0fa18
[42949414.330000] $24   : 00000047 00000000
[42949414.330000] $28   : 87d44000 87d45ee8 00000000 80020bf0
[42949414.340000] Hi    : 0000002c
[42949414.340000] Lo    : 0003aac9
[42949414.350000] epc   : 8003409c do_dsemulret+0x40/0xf4     Not tainted
[42949414.350000] ra    : 80020bf0 do_ade+0x20/0x3c0
[42949414.360000] Status: 10000403    KERNEL EXL IE
[42949414.360000] Cause : 00800010
[42949414.370000] BadVA : 1440002a
[42949414.370000] PrId  : 02d0024f (Ingenic JZRISC)
[42949414.370000] Modules linked in:
[42949414.380000] Process keylaunch (pid: 1222, threadinfo=87d44000,
task=87d6e1
78)
[42949414.380000] Stack : 87d6e178 802dca50 8c830004 30620002 87d45f30
0041bbe1
80020bf0 00414660
[42949414.390000]         00414660 0041bbe1 ffffffff 00414660 00414660
0041bbe1
ffffffff 00414660
[42949414.400000]         80018fa0 80019120 004d8474 004d843c 004d844c
004d8a02
ffffffff 00000000
[42949414.410000]         00000000 10000400 2ae66754 00418690 0041bbd9
0041bbe1
00000024 0041469c
[42949414.420000]         00000023 00414690 00000003 00000022 2ac9a200
2aca0000
ffffffff 00401820
[42949414.430000]         ...
[42949414.430000] Call Trace:
[42949414.430000] [&lt;8003409c&gt;] do_dsemulret+0x40/0xf4
[42949414.440000] [&lt;80020bf0&gt;] do_ade+0x20/0x3c0
[42949414.440000] [&lt;80018fa0&gt;] ret_from_exception+0x0/0x24
[42949414.450000]
[42949414.450000]
[42949414.450000] Code: 2484e528  00601021  8e060004 &lt;8e070008&gt; 3c048034
 004310
25  2484e550  10400013  00c02821
[42949414.550000] do_dsemulret: bad magics, insn=0x00000024
[42949414.560000] do_dsemulret: cannot access emuframe
[42949414.560000] Cpu 0
[42949414.560000] $ 0   : 00000000 10000400 00000000 803bf8d0
[42949414.570000] $ 4   : 8037c3d0 87d9fefc 00000005 00000005
[42949414.570000] $ 8   : ebd8a1cf 00000005 feced300 ffffffff
[42949414.580000] $12   : ec71384f 00000005 ffffffff 803bfd88
[42949414.590000] $16   : 14400022 87d45f30 ffffffff 00414660
[42949414.590000] $20   : 00000000 00000000 00000000 2ac0fa18
[42949414.600000] $24   : 00000001 803bfda8
[42949414.600000] $28   : 87d44000 87d45ee8 00000000 800340bc
[42949414.610000] Hi    : 00989643
[42949414.610000] Lo    : d5905180
[42949414.610000] epc   : 800340d4 do_dsemulret+0x78/0xf4     Not tainted
[42949414.620000] ra    : 800340bc do_dsemulret+0x60/0xf4
[42949414.630000] Status: 10000403    KERNEL EXL IE
[42949414.630000] Cause : 20800010
[42949414.630000] BadVA : 1440002e
[42949414.640000] PrId  : 02d0024f (Ingenic JZRISC)
[42949414.640000] Modules linked in:
[42949414.650000] Process keylaunch (pid: 1222, threadinfo=87d44000,
task=87d6e1
78)
[42949414.650000] Stack : 87d6e178 00000024 00000024 0041469c 87d45f30
0041bbe1
80020bf0 00414660
[42949414.660000]         00414660 0041bbe1 ffffffff 00414660 00414660
0041bbe1
ffffffff 00414660
[42949414.670000]         80018fa0 80019120 004d8474 004d843c 004d844c
004d8a02
ffffffff 00000000
[42949414.680000]         00000000 10000400 2ae66754 00418690 0041bbd9
0041bbe1
00000024 0041469c
[42949414.690000]         00000023 00414690 00000003 00000022 2ac9a200
2aca0000
ffffffff 00401820
[42949414.700000]         ...
[42949414.700000] Call Trace:
[42949414.700000] [&lt;800340d4&gt;] do_dsemulret+0x78/0xf4
[42949414.710000] [&lt;80020bf0&gt;] do_ade+0x20/0x3c0
[42949414.710000] [&lt;80018fa0&gt;] ret_from_exception+0x0/0x24
[42949414.720000]
[42949414.720000]
[42949414.720000] Code: 24420001  ac620014  00001021 &lt;8e03000c&gt; 14400010
 240400
0a  ae2300ac  24020001  8fbf0018
[42949416.460000] do_dsemulret: bad magics, insn=0x8c830004
[42949416.460000] do_dsemulret: cannot access emuframe
[42949416.470000] Cpu 0
[42949416.470000] $ 0   : 00000000 10000400 00000000 00000000
[42949416.480000] $ 4   : 8033e528 80000000 00425c90 00000019
[42949416.480000] $ 8   : 10000401 1000001e 36384658 72617453
[42949416.490000] $12   : 87d744c0 00000000 87d744c0 00000000
[42949416.490000] $16   : 14400022 87b0bf30 00414008 0000003f
[42949416.500000] $20   : 00425c90 00400000 00400000 00000000
[42949416.500000] $24   : 00000003 00000000
[42949416.510000] $28   : 87b0a000 87b0bee8 2ae64858 80020bf0
[42949416.520000] Hi    : 307e68e8
[42949416.520000] Lo    : e1cb4540
[42949416.520000] epc   : 80034098 do_dsemulret+0x3c/0xf4     Not tainted
[42949416.530000] ra    : 80020bf0 do_ade+0x20/0x3c0
[42949416.530000] Status: 10000403    KERNEL EXL IE
[42949416.540000] Cause : 10800010
[42949416.540000] BadVA : 14400026
[42949416.540000] PrId  : 02d0024f (Ingenic JZRISC)
[42949416.550000] Modules linked in:
[42949416.550000] Process keylaunch (pid: 1274, threadinfo=87b0a000,
task=87daed
f8)
[42949416.560000] Stack : 87daedf8 802dca50 8c830004 30620002 87b0bf30
0041bbd9
80020bf0 0000003f
[42949416.570000]         00425c94 0041bbd9 00414008 0000003f 00425c94
0041bbd9
00414008 0000003f
[42949416.580000]         80018fa0 80019120 004d928c 004d8e44 004d9254
004daa9c
ffffffff 00000000
[42949416.590000]         00000000 10000400 2ae66754 00000001 0041bbd1
00000001
00425c90 00000019
[42949416.600000]         ffffffff ffffffff 36384658 72617453 87d744c0
00000000
87d744c0 00000000
[42949416.600000]         ...
[42949416.610000] Call Trace:
[42949416.610000] [&lt;80034098&gt;] do_dsemulret+0x3c/0xf4
[42949416.610000] [&lt;80020bf0&gt;] do_ade+0x20/0x3c0
[42949416.620000] [&lt;80018fa0&gt;] ret_from_exception+0x0/0x24
[42949416.620000]
[42949416.630000]
[42949416.630000] Code: 1460002b  2484e528  00601021 &lt;8e060004&gt; 8e070008
 3c0480
34  00431025  2484e550  10400013
[42949417.210000] do_dsemulret: bad magics, insn=0xaca20000
[42949417.970000] do_dsemulret: cannot access emuframe
[42949417.970000] Cpu 0
[42949417.980000] $ 0   : 00000000 10000400 fffffff2 00000000
[42949417.980000] $ 4   : 8033e528 80000000 00425c90 00000019
[42949417.990000] $ 8   : 10000401 1000001e 36384658 72617453
[42949417.990000] $12   : 87d744c0 00000000 87d744c0 00000000
[42949418.000000] $16   : 14400022 87b0bf30 00414008 0000003f
[42949418.000000] $20   : 00425c90 00400000 00400000 00000000
[42949418.010000] $24   : 00000003 00000000
[42949418.020000] $28   : 87b0a000 87b0bee8 2ae64858 80020bf0
[42949418.020000] Hi    : 307e68e8
[42949418.020000] Lo    : e1cb4540
[42949418.030000] epc   : 8003409c do_dsemulret+0x40/0xf4     Not tainted
[42949418.030000] ra    : 80020bf0 do_ade+0x20/0x3c0
[42949418.040000] Status: 10000403    KERNEL EXL IE
[42949418.040000] Cause : 00800010
[42949418.050000] BadVA : 1440002a
[42949418.050000] PrId  : 02d0024f (Ingenic JZRISC)
[42949418.060000] Modules linked in:
[42949418.060000] Process keylaunch (pid: 1274, threadinfo=87b0a000,
task=87daed
f8)
[42949418.070000] Stack : 87daedf8 802dca50 8c830004 30620002 87b0bf30
0041bbd9
80020bf0 0000003f
[42949418.070000]         00425c94 0041bbd9 00414008 0000003f 00425c94
0041bbd9
00414008 0000003f
[42949418.080000]         80018fa0 80019120 004d928c 004d8e44 004d9254
004daa9c
ffffffff 00000000
[42949418.090000]         00000000 10000400 2ae66754 00000001 0041bbd1
00000001
00425c90 00000019
[42949418.100000]         ffffffff ffffffff 36384658 72617453 87d744c0
00000000
87d744c0 00000000
[42949418.110000]         ...
[42949418.110000] Call Trace:
[42949418.120000] [&lt;8003409c&gt;] do_dsemulret+0x40/0xf4
[42949418.120000] [&lt;80020bf0&gt;] do_ade+0x20/0x3c0
[42949418.120000] [&lt;80018fa0&gt;] ret_from_exception+0x0/0x24
[42949418.130000]
[42949418.130000]
[42949418.130000] Code: 2484e528  00601021  8e060004 &lt;8e070008&gt; 3c048034
 004310
25  2484e550  10400013  00c02821
[42949419.210000] do_dsemulret: bad magics, insn=0x00425c90
[42949419.210000] do_dsemulret: cannot access emuframe
[42949419.220000] Cpu 0
[42949419.220000] $ 0   : 00000000 10000400 00000000 803bf8d0
[42949419.220000] $ 4   : 8037c3d0 87d9fefc 00000006 00000000
[42949419.230000] $ 8   : 3c317acd 00000006 feced300 ffffffff
[42949419.230000] $12   : 3cca114d 00000006 ffffffff 803bfd88
[42949419.240000] $16   : 14400022 87b0bf30 00414008 0000003f
[42949419.250000] $20   : 00425c90 00400000 00400000 00000000
[42949419.250000] $24   : 00000001 803bfda8
[42949419.260000] $28   : 87b0a000 87b0bee8 2ae64858 800340bc
[42949419.260000] Hi    : 00989644
[42949419.270000] Lo    : eb524680
[42949419.270000] epc   : 800340d4 do_dsemulret+0x78/0xf4     Not tainted
[42949419.280000] ra    : 800340bc do_dsemulret+0x60/0xf4
[42949419.280000] Status: 10000403    KERNEL EXL IE
[42949419.290000] Cause : 20800010
[42949419.290000] BadVA : 1440002e
[42949419.290000] PrId  : 02d0024f (Ingenic JZRISC)
[42949419.300000] Modules linked in:
[42949419.300000] Process keylaunch (pid: 1274, threadinfo=87b0a000,
task=87daed
f8)
[42949419.310000] Stack : 87daedf8 00425c90 00425c90 00000019 87b0bf30
0041bbd9
80020bf0 0000003f
[42949419.320000]         00425c94 0041bbd9 00414008 0000003f 00425c94
0041bbd9
00414008 0000003f
[42949419.320000]         80018fa0 80019120 004d928c 004d8e44 004d9254
004daa9c
ffffffff 00000000
[42949419.330000]         00000000 10000400 2ae66754 00000001 0041bbd1
00000001
00425c90 00000019
[42949419.340000]         ffffffff ffffffff 36384658 72617453 87d744c0
00000000
87d744c0 00000000
[42949419.350000]         ...
[42949419.350000] Call Trace:
[42949419.360000] [&lt;800340d4&gt;] do_dsemulret+0x78/0xf4
[42949419.360000] [&lt;80020bf0&gt;] do_ade+0x20/0x3c0
[42949419.370000] [&lt;80018fa0&gt;] ret_from_exception+0x0/0x24
[42949419.370000]
[42949419.370000]
[42949419.370000] Code: 24420001  ac620014  00001021 &lt;8e03000c&gt; 14400010
 240400
0a  ae2300ac  24020001  8fbf0018

  </pre>
</blockquote>
<br>
</body>
</html>

--------------030001090906030806010308--
