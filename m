Received:  by oss.sgi.com id <S42353AbQJFV6K>;
	Fri, 6 Oct 2000 14:58:10 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:38902 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42342AbQJFV6I>;
	Fri, 6 Oct 2000 14:58:08 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e96IYOx11537;
	Fri, 6 Oct 2000 11:34:24 -0700
Message-ID: <39DE7DD3.7A67B19E@mvista.com>
Date:   Fri, 06 Oct 2000 18:35:15 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: load_unaligned() and "uld" instruction
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com> <20001005141354.E30075@bacchus.dhis.org> <39DD26CC.3805FFE8@mvista.com> <00d101c02f04$3a6d7340$0deca8c0@Ulysses> <39DD55E9.AFCACB0E@mvista.com> <011801c02f19$1283f6a0$0deca8c0@Ulysses> <39DD68DE.E9B26A3D@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Jun Sun wrote:
> 
> Ralf, I notice you have fixed it in the CVS tree.  Just did a test, and
> it looks good here.
> 

I was too soon to say that ... :-)

While the __ldq_u() did work, I had a couple of syntax problems with
put_unaligned().  See the patch below.

In addition, my usb subsystem now hangs.  It might mean a bug in the new
unaligned.h or the fix to unaligned.h reveals another bug.  I will let
you know.

Jun

--- unaligned.h.ralf    Fri Oct  6 18:32:34 2000
+++ unaligned.h Fri Oct  6 18:01:43 2000
@@ -117,20 +117,20 @@
        __val;                                                         
\
 })

-#define put_unaligned(x,ptr)                                          
\
+#define put_unaligned(val,ptr)                                        
\
 do {                                                                  
\
        switch (sizeof(*(ptr))) {                                      
\
        case 1:                                                        
\
-               *(unsigned char *)ptr = (val);                         
\
+               *(unsigned char *)(ptr) = (val);                       
\
                break;                                                 
\
        case 2:                                                        
\
-               __stw_u(val, (unsigned short *)ptr);                   
\
+               __stw_u(val, (unsigned short *)(ptr));                 
\
                break;                                                 
\
        case 4:                                                        
\
-               __stl_u(val, (unsigned int *)ptr);                     
\
+               __stl_u(val, (unsigned int *)(ptr));                   
\
                break;                                                 
\
        case 8:                                                        
\
-               __stq_u(val, (unsigned long long *)ptr);               
\
+               __stq_u(val, (unsigned long long *)(ptr));             
\
                break;                                                 
\
        default:                                                       
\
                __put_unaligned_bad_length();                          
\
