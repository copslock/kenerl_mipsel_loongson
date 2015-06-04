Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 10:14:35 +0200 (CEST)
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:52087 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007212AbbFDIOdbUEG4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 10:14:33 +0200
Received: from resomta-ch2-02v.sys.comcast.net ([69.252.207.98])
        by resqmta-ch2-09v.sys.comcast.net with comcast
        id c8ES1q00227uzMh018ESYp; Thu, 04 Jun 2015 08:14:26 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-02v.sys.comcast.net with comcast
        id c8ER1q00242s2jH018ERER; Thu, 04 Jun 2015 08:14:26 +0000
Message-ID: <557008D5.2060103@gentoo.org>
Date:   Thu, 04 Jun 2015 04:14:13 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: IP30: Oops if 'cat /proc/iomem', and kexec for 64bit?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433405666;
        bh=zw6VQuJCaPzpwjC0XkWvHuVPRBNjf8jqEbUWvK6uDgE=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=i+Oh5rWRq+3fij1uxn5RbkT/3cluTmQu2gAVirObghatkhmvUMugtIFaziwBlH93N
         k4UDCoBUSzNvpmUPONbgFfYHLMuLDlkUZNEtj/1/ajeSzSxtjM+iru/89g73xQulC/
         iSJtuGwVVvvxqiB2ijKG3fT/lPm+RxFSrac58/xYUUeI8zGU0/2vtiYPU3dWIR8E0z
         ab7wbQxH6SMY4VBoDdIvwi54nm2FyqCO6Rrnqk5tvzS0hoCTuFb0cynUfLioeUgTHV
         8elI/CO7PMM1HQ55ou/VP8NmI97wHRyN4OI/GaH3wO2/+C0edkqkvfPoVAzDWhvd3j
         nH3hOViF5CXLw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Randomly wanted to try kexec out on the Octane, and quickly discovered a
repeatable Oops if I run 'cat /proc/iomem':

[  136.592190] CPU 1 Unable to handle kernel paging request at virtual address 0000000000000020, epc == a8000000200333e0, ra == a8000000201616a4
[  136.592230] Oops[#1]:
[  136.602805] CPU: 1 PID: 1425 Comm: cat Not tainted 4.1.0-rc6-mipsgit-20150602 #14
[  136.613685] task: a800000096ecee80 ti: a80000009b9f0000 task.ti: a80000009b9f0000
[  136.624785] $ 0   : 0000000000000000 ffffffffb404fce0 0000000000000000 a8000000209108d8
[  136.636172] $ 4   : a800000097096180 a80000002090fef8 0000000000000002 0000000000000000
[  136.647579] $ 8   : 0000000000000005 0000000000000004 0000000000000008 0000000000000008
[  136.658916] $12   : 0000000000000008 0000000000000004 0000000000000000 a80000009c19008b
[  136.670145] $16   : a800000097096180 0000000000020000 0000000000000000 a80000009b9ffe60
[  136.681288] $20   : a800000097b0e200 a8000000970961c0 0000000077750000 0000000000000099
[  136.692393] $24   : a80000009c1a0000 0000000000000020
[  136.703501] $28   : a80000009b9f0000 a80000009b9ffd00 a80000002090fef8 a8000000201616a4
[  136.714663] Hi    : 0000000000000000
[  136.725640] Lo    : 0000000000000000
[  136.736593] epc   : a8000000200333e0 r_show+0x48/0xd0
[  136.747562] ra    : a8000000201616a4 seq_read+0x41c/0x550
[  136.758538] Status: b404fce3 KX SX UX KERNEL EXL IE
[  136.769699] Cause : 80000008
[  136.780666] BadVA : 0000000000000020
[  136.791608] PrId  : 00000f24 (R14000)
[  136.802503] Process cat (pid: 1425, threadinfo=a80000009b9f0000, task=a800000096ecee80, tls=000000007796b190)
[  136.813856] Stack : a800000020893668 a800000097096180 0000000000020000 a8000000201616a4
                  0000000000000005 0000000000000004 0000000000000001 a800000098120600
                  a8000000804abe00 fffffffffffffffb a80000009b9ffe60 0000000000020000
                  0000000000000003 0000000000000004 0000000000000016 0000000000000000
                  00000000100099a0 a80000002019fce8 a8000000980da960 0000000077750000
                  a800000097b0e200 a80000002013269c a80000009b9ffeb0 0000000000000051
                  0000000077740004 a80000002001fa38 a800000000030002 a80000002007d150
                  ffffffffb404fce1 a80000009b9ffe40 a8000000980da960 0000000077740000
                  0000000000040000 0000000077800000 000000000000ffff 0000000077750000
                  a800000097b0e200 a800000020132818 a800000097b0e200 ffffffff97b0e200
                  ...
[  136.943997] Call Trace:
[  136.955680] [<a8000000200333e0>] r_show+0x48/0xd0
[  136.967354] [<a8000000201616a4>] seq_read+0x41c/0x550
[  136.978960] [<a80000002019fce8>] proc_reg_read+0x70/0xa8
[  136.990587] [<a80000002013269c>] __vfs_read+0x2c/0x110
[  137.002116] [<a800000020132818>] vfs_read+0x98/0x178
[  137.013533] [<a800000020132d9c>] SyS_read+0x5c/0xf0
[  137.024902] [<a800000020019a94>] handle_sysn32+0x54/0x80

[  137.047603]
               Code: 50620005  00063040  24c60001 <54c8fffc> dc420020  2406000a  bfb40000  3c07a800  3c03208d
[  137.070940] ---[ end trace bc92258e11109009 ]---
[  137.082714] note: cat[1425] exited with preempt_count 1


Which GDB says is:
   (gdb) l *(r_show+0x48)
   0xa8000000200333e0 is in r_show (kernel/resource.c:111).
   106             struct resource *root = m->private;
   107             struct resource *r = v, *p;
   108             int width = root->end < 0x10000 ? 4 : 8;
   109             int depth;
   110
-> 111             for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent)
   112                     if (p->parent == root)
   113                             break;
   114             seq_printf(m, "%*s%0*llx-%0*llx : %s\n",
   115                             depth * 2, "",

So I dug around, and came across this patch from way back in 2004:
http://www.linux-mips.org/archives/linux-mips/2004-06/msg00013.html

If I apply just the second hunk, the Oops goes away and I get this output:

# cat /proc/iomem
00000000-00003fff : reserved
  00000000-00000000 : Crash kernel
1b200000-1b9fffff : Bridge MEM
1d200000-1d9fffff : Bridge MEM
1f200000-1f9fffff : Bridge MEM
20004000-20a68fff : System RAM
  20004000-20741ae7 : Kernel code
  20741ae8-2094c62f : Kernel data
20a69000-20efffff : System RAM
20f00000-20ffffff : System RAM
21000000-9fffffff : System RAM
b041000000-b0410fffff : ioc3
b041100000-b0411fffff : ioc3
b041200000-b0412fffff : ioc3
b041300000-b0413fffff : ioc3
f041000000-f0410fffff : ioc3
f041140000-f041141fff : rad1

(I have a MENET board installed, hence the five IOC3 devices)

Yet, this Oops cannot be triggered on IP27.  So I suspect the root cause is
something in Octane's memory setup isn't quite right, but I am not sure what.
It definitely can detect all installed memory just fine, and I've yet to
experience any issues related to invalid memory addresses.

What are some good places in the code, especially any specific
machine-dependent subsystems, that I should look and compare with other systems
to maybe trace down the root cause?

-----------

Other question, is kexec seems to be specific to 32bit at the moment.  Has it
been tested on 64bit MIPS?  Under Octane, I get this when I patch/kludge the
/proc/iomem bug and run 'kexec -l </path/to/kernel> --append=<args>':

Base address: 0x20004000 is not page aligned

Octane's standard load address is 0xa800000020004000, so the upper 32-bits are
getting truncated off either by whatever feeds /proc/iomem, or by kexec-tools
itself.  Which area should I focus on?

Thanks!,

--J
