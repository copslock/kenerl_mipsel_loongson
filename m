Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAMGbQL20816
	for linux-mips-outgoing; Thu, 22 Nov 2001 08:37:26 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAMGbKo20800
	for <linux-mips@oss.sgi.com>; Thu, 22 Nov 2001 08:37:20 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA11880;
	Thu, 22 Nov 2001 07:37:11 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA07072;
	Thu, 22 Nov 2001 07:37:12 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fAMFbBA01614;
	Thu, 22 Nov 2001 16:37:11 +0100 (MET)
Message-ID: <3BFD1BA7.C4490465@mips.com>
Date: Thu, 22 Nov 2001 16:37:11 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: FPU test on RedHat7.1
Content-Type: multipart/mixed;
 boundary="------------9DC6D74387B6EA7415A6F4BB"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------9DC6D74387B6EA7415A6F4BB
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

The attached tests fails on my RedHat7.1 system, but works fine on my
old HardHat5.1.
Anyone got any idea.

compile:
g++ -o fpu_test fpu_test.cc

/Carsten

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------9DC6D74387B6EA7415A6F4BB
Content-Type: text/plain; charset=iso-8859-15;
 name="fpu_test.cc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fpu_test.cc"

#include <math.h>
#include <stdio.h>

int main( int argc,char * argv[ ] )
{

  double res;
  
  union {
    unsigned long long l;
    double d;
  } op1, op2;

  op1.l = 0x7fefffffffffffff;
  op2.l = 0x0000000000000001;  

  printf("%llx %llx\n", op1.l, op2.l);
  
  res = remainder(op1.d, op2.d);

  printf("%llx\n", res);

}

--------------9DC6D74387B6EA7415A6F4BB--
