Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1EMeX201815
	for linux-mips-outgoing; Thu, 14 Feb 2002 14:40:33 -0800
Received: from mailhost.taec.toshiba.com (mailhost.taec.com [209.243.128.33])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1EMeQ901812
	for <linux-mips@oss.sgi.com>; Thu, 14 Feb 2002 14:40:26 -0800
Received: from hdqmta.taec.com (hdqmta [209.243.180.59])
	by mailhost.taec.toshiba.com (8.8.8+Sun/8.8.8) with ESMTP id NAA29253
	for <linux-mips@oss.sgi.com>; Thu, 14 Feb 2002 13:40:18 -0800 (PST)
Subject: Tools issue
To: linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OF7ACD949C.CF1ABCAF-ON88256B60.00728091@taec.com>
From: Adrian.Hulse@taec.toshiba.com
Date: Thu, 14 Feb 2002 13:42:31 -0800
X-MIMETrack: Serialize by Router on HDQMTA/TOSHIBA_TAEC(Release 5.0.8 |June 18, 2001) at
 02/14/2002 01:39:16 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am experiencing some strange behaviour dependent on the tools I use and I
was wondering if anyone on this list, has experienced similar problems or
may know the answer to my problem.

To date I have been using the following tools from the SGI site to
successfully compile and boot a 2.4.12 little endian mips kernel :

binutils-mipsel-linux-2.8.1-2.i386.rpm
egcs-mipsel-linux-1.1.2-4.i386.rpm

As an experiment I decided to try the "toolchain-20011020" tools also from
the SGI site to compile the exact same kernel, but the compile fails with
the following 2 errors :

ctfb.c:1158: warning: duplicate `const'
{standard input}:11123: Error: expression too complex
{standard input}:11123: Fatal Error: internal Error, line 1980,
../../tools-20011020/gas/config/tc-mips.c
make[3]: ***[ctfb.o] Error 2

int-handler.s:59: Error: missing ')'
int-handler.s:59: Error: illegal operands `lui'
int-handler.s:60: Error: missing ')'
int-handler.s:60: Error: illegal operands `sb'
make[1]: *** [ int-handler.o ] Error 1

I can get around the first error by just disabling CONFIG_FB_CT in the
config and recompiling. Note the monta vista toolchain also fails in the
same file, with I think the same error.
I can get around the second error by one of two methods :
a, just comment it out because all it's doing is lighting up an led
according to the interrupt received
b, by changing a parenthesised define to non-parenthesised form :

int-handler.S
<l59>     lui  t1, %hi(TSDB_LED_ADDR)
<l60>     sb   t0, %lo(TSDB_LDE_ADDR)(t1)

Failed define :
#define   TSDB_LED_ADDR  (KSEG1 + TSDB_LB_PCU_APERTURE + 0x05100020)

Compilable define :
#define   TSDB_LED_ADDR  KSEG1 + TSDB_LB_PCU_APERTURE + 0x05100020

So with the above 2 kludges I can get the kernel to compile, but now when I
come to boot it, the board it just locks failing somewhere in console_init
( currently investigating ).

Anyone else seen anything like this and know of a solution to the problem ?
Or to paraphrase Dominic Sweetman, maybe i should just stay with the "pick
your own version folklore" method of picking tools :).

Thx
