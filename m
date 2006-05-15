Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 10:48:55 +0200 (CEST)
Received: from krt.tmd.ns.ac.yu ([147.91.177.65]:53659 "EHLO krt.neobee.net")
	by ftp.linux-mips.org with ESMTP id S8133411AbWEOIsp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2006 10:48:45 +0200
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id k4F9DrZ7028090
	for <linux-mips@linux-mips.org>; Mon, 15 May 2006 11:13:53 +0200
Received: from krt.neobee.net ([127.0.0.1])
 by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 25991-09 for <linux-mips@linux-mips.org>;
 Mon, 15 May 2006 11:13:53 +0200 (CEST)
Received: from [192.168.0.91] ([192.168.0.91])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id k4F9DfUQ028080
	for <linux-mips@linux-mips.org>; Mon, 15 May 2006 11:13:42 +0200
Message-ID: <4468405C.3090005@micronasnit.com>
Date:	Mon, 15 May 2006 10:48:28 +0200
From:	Dusko Dobranic <dusko.dobranic@micronasnit.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: gcc-4.0.3, gcc-4.1.0 no output with out
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at krt.neobee.net
Return-Path: <dusko.dobranic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dusko.dobranic@micronasnit.com
Precedence: bulk
X-list: linux-mips

Hello,

I'm using linux kernel 2.6.15, uclibc-0.9.28 and toolchains (built using 
  buildroot) on embedded MIPS platform based od 4KEc CPU.

Simple examples compiled with gcc-4.0.3 or gcc-4.1.0 not producing
output. There is a piece of code:

  for (i = 0; i < v.size(); i++)
  {
	out << v[i].s << " :\t"
             << v[i].t * (double(1000000)/n)/CLOCKS_PER_SEC
             << " ms"
             << endl;

//        printf("%s    :\t %2.3f ms\n", v[i].s, v[i].t *
(double(1000000)/n)/CLOCKS_PER_SEC);
  }

When execute, output looks like this:

$./d_1++ 100000
./d_1 100000

virtual px->f(1)             :   ms
ptr-to-fct p[1](ps,1)        :   ms
virtual x.f(1)               :   ms
ptr-to-fct p[1](&s,1)        :   ms
member px->g(1)              :   ms
global g(ps,1)               :   ms
member x.g(1)                :   ms
global g(&s,1)               :   ms
static X::h(1)               :   ms
global h(1)                  :   ms
inline px->k(1)              :   ms
macro K(ps,1)                :   ms
inline x.k(1)                :   ms
macro K(&s,1)                :   ms
base1 member pc->g(i)        :   ms
base2 member pc->gg(i)       :   ms
base1 virtual pa->f(i)       :   ms
base2 virtual pb->ff(i)      :   ms
base1 down-cast cast(pa,pc)   :  ms
base2 down-cast cast(pb,pc)   :  ms
base1 up-cast cast(pc,pa)     :  ms
base2 up-cast cast(pc,pb)     :  ms
base2 cross-cast cast(pb,pa)  :  ms
base1 down-cast2 cast(pa,pcc) :  ms
base2 down-cast  cast(pb,pcc) :  ms
base1 up-cast cast(pcc,pa)    :  ms
base2 up-cast2 cast(pcc,pb)   :  ms
base2 cross-cast2 cast(pa,pb) :  ms
base1 cross-cast2 cast(pb,pa) :  ms
vbase member pd->gg(i)       :   ms
vbase virtual pa->f(i)       :   ms
vbase down-cast cast(pa,pd)   :  ms
vbase up-cast cast(pd,pa)     :  ms
vbase typeid(pa)             :   ms
vbase typeid(pd)             :   ms
pmf virtual (pa->*pmf)(i)    :   ms
pmf (pa->*pmf)(i)            :   ms
call by_ref(pp)              :   ms
call by_val(pp)              :   ms
call ptr-to-fct oper(h,glob) :   ms
call fct-obj oper(fct,glob)  :   ms

Commented line with printf do produce output:

# ./d_1 100000
./d_1 100000

virtual px->f(1)             :  0.5 ms
ptr-to-fct p[1](ps,1)        :  0.5 ms
virtual x.f(1)               :  0.5 ms
ptr-to-fct p[1](&s,1)        :  0.5 ms
member px->g(1)              :  0.5 ms
global g(ps,1)               :  0.5 ms
member x.g(1)                :  0.6 ms
global g(&s,1)               :  0.5 ms
static X::h(1)               :  0.4 ms
global h(1)                  :  0.5 ms
inline px->k(1)              :  0.5 ms
macro K(ps,1)                :  0.2 ms
inline x.k(1)                :  0.5 ms
macro K(&s,1)                :  0.2 ms
base1 member pc->g(i)        :  0.5 ms
base2 member pc->gg(i)       :  0.5 ms
base1 virtual pa->f(i)       :  0.6 ms
base2 virtual pb->ff(i)      :  0.6 ms
base1 down-cast cast(pa,pc)   : 0.5 ms
base2 down-cast cast(pb,pc)   : 0.6 ms
base1 up-cast cast(pc,pa)     : 2.4 ms
base2 up-cast cast(pc,pb)     : 2.2 ms
base2 cross-cast cast(pb,pa)  : 4.7 ms
base1 down-cast2 cast(pa,pcc) : 0.5 ms
base2 down-cast  cast(pb,pcc) : 0.6 ms
base1 up-cast cast(pcc,pa)    : 2.4 ms
base2 up-cast2 cast(pcc,pb)   : 2.2 ms
base2 cross-cast2 cast(pa,pb) : 4.7 ms
base1 cross-cast2 cast(pb,pa) : 4.3 ms
vbase member pd->gg(i)       :  0.6 ms
vbase virtual pa->f(i)       :  0.9 ms
vbase down-cast cast(pa,pd)   : 0.7 ms
vbase up-cast cast(pd,pa)     : 4.4 ms
vbase typeid(pa)             :  0.8 ms
vbase typeid(pd)             :  0.8 ms
pmf virtual (pa->*pmf)(i)    :  1.2 ms
pmf (pa->*pmf)(i)            :  0.7 ms
call by_ref(pp)              :  0.5 ms
call by_val(pp)              :  0.5 ms
call ptr-to-fct oper(h,glob) :  0.8 ms
call fct-obj oper(fct,glob)  :  0.8 ms

When using gcc-3.4.2 everything is OK.
