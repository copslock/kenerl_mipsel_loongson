Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 21:16:34 +0000 (GMT)
Received: from amdext2.amd.com ([IPv6:::ffff:163.181.251.1]:27861 "EHLO
	amdext2.amd.com") by linux-mips.org with ESMTP id <S8225196AbTCDVQd>;
	Tue, 4 Mar 2003 21:16:33 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext2.amd.com (8.9.3/8.9.3/AMD) with ESMTP id PAA04541
	for <linux-mips@linux-mips.org>; Tue, 4 Mar 2003 15:16:22 -0600 (CST)
Received: from 163.181.250.1SAUSGW02.amd.com with ESMTP (AMD SMTP Relay
 (MMS v5.0)); Tue, 04 Mar 2003 15:16:16 -0600
X-Server-Uuid: BB5E7757-34FD-4146-B9CC-0950D472AE87
Received: from pcsmail.amd.com (pcsmail.amd.com [163.181.41.222]) by
 amdint2.amd.com (8.9.3/8.9.3/AMD) with ESMTP id PAA23911 for
 <linux-mips@linux-mips.org>; Tue, 4 Mar 2003 15:16:14 -0600 (CST)
Received: from ardgw29.amd.com (ardgw29.amd.com [163.181.41.29]) by
 pcsmail.amd.com (8.11.6/8.11.6) with ESMTP id h24LGEa21737; Tue, 4 Mar
 2003 15:16:14 -0600
Date: Tue, 4 Mar 2003 15:08:27 -0600 (CST)
From: "Yogesh Chaudhary" <yogesh.chaudhary@amd.com>
X-X-Sender: yogesh@ardgw29.amd.com
To: linux-mips@linux-mips.org
cc: "Yogesh Chaudhary" <yogesh.chaudhary@amd.com>
Subject: convert into MIPS
Message-ID: <Pine.GSO.4.51.0303041505390.3806@ardgw29.amd.com>
MIME-Version: 1.0
X-WSS-ID: 127BC82A2120175-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <yogesh.chaudhary@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yogesh.chaudhary@amd.com
Precedence: bulk
X-list: linux-mips


Hi All,

can anyone help me converting this little piece of x86 code to MIPS.

here it is...

#define fixfixmul(a,b) \
   ( { long __result = (a), __arg = (b); \
       asm("imul %2;" \
           "shrd %3,%2,%0;" \
          : "=a" (__result) \
          : "0"  (__result), "d"  (__arg) , "I" (FX_PRECIS) ); \
       assert( \
             ((fix2float(__result) - fix2float(a)*fix2float(b) > -0.2) \
               && \
              (fix2float(__result) - fix2float(a)*fix2float(b) <  0.2)) \
              || \
              (printf("fixfixmul %f %f = %f, should be %f\n", \
                      fix2float(a),fix2float(b),fix2float(__result), \
                      fix2float(a)*fix2float(b)) \
              && 0) \
             ); \
       __result; \
      } \
   )


thanks, Yogesh


--------------------------------------------------------------------------
Yogesh Chaudhary
Advanced Micro Devices,Inc ( PCS )
9500 Arboretum Blvd., Suite 400                       Phone:  512.602.5422
Austin, TX 78759                                       Fax: 512.602.5051
