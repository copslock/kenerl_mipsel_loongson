Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 17:39:07 +0000 (GMT)
Received: from RT-soft-2.Moscow.itn.ru ([IPv6:::ffff:80.240.96.70]:47335 "HELO
	mail.dev.rtsoft.ru") by linux-mips.org with SMTP
	id <S8225554AbUATRjH>; Tue, 20 Jan 2004 17:39:07 +0000
Received: (qmail 17281 invoked from network); 20 Jan 2004 17:18:22 -0000
Received: from unknown (HELO dev.rtsoft.ru) (192.168.1.132)
  by mail.dev.rtsoft.ru with SMTP; 20 Jan 2004 17:18:22 -0000
Message-ID: <400D6877.1000105@dev.rtsoft.ru>
Date: Tue, 20 Jan 2004 20:42:15 +0300
From: Pavel Kiryukhin <savl@dev.rtsoft.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: __MIPSEL__ in sys32_rt_sigtimedwait
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <savl@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: savl@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

Hi all,
my question - does endiannes matters in sigset translation in 
sys32_rt_sigtimedwait (arch/mips/signal32.c)?

===================
@@ -827,18 +827,10 @@
         return -EFAULT;
 
     switch (_NSIG_WORDS) {
-#ifdef __MIPSEB__
     case 4: these.sig[3] = these32.sig[6] | (((long)these32.sig[7]) << 32);
     case 3: these.sig[2] = these32.sig[4] | (((long)these32.sig[5]) << 32);
     case 2: these.sig[1] = these32.sig[2] | (((long)these32.sig[3]) << 32);
     case 1: these.sig[0] = these32.sig[0] | (((long)these32.sig[1]) << 32);
-#endif
-#ifdef __MIPSEL__
-    case 4: these.sig[3] = these32.sig[7] | (((long)these32.sig[6]) << 32);
-    case 3: these.sig[2] = these32.sig[5] | (((long)these32.sig[4]) << 32);
-    case 2: these.sig[1] = these32.sig[3] | (((long)these32.sig[2]) << 32);
-    case 1: these.sig[0] = these32.sig[1] | (((long)these32.sig[0]) << 32);
-#endif
     }
 
     /*
===================
Regards,
Pavel Kiryukhin
