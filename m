Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f767Xvf29060
	for linux-mips-outgoing; Mon, 6 Aug 2001 00:33:57 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f767XtV29057
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 00:33:56 -0700
Message-Id: <200108060733.f767XtV29057@oss.sgi.com>
Received: (qmail 18376 invoked from network); 6 Aug 2001 07:28:20 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 6 Aug 2001 07:28:20 -0000
Date: Mon, 6 Aug 2001 15:36:29 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: XFree86 generic.c problem
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello,linux-mips

   When trying to crossing compile XFree86 server for my linux on mipsel
machine(idt64474,p6032) i find some problems:

1.     In: xc/programs/Xserver/hw/xfree86/int10/generic
        write_w & write_l 
   They use
#if X_BYTE_ORDER == X_LITTLE_ENDIAN
    if (OFF(addr + 3) > 2)
      { V_ADDR_WL(addr, val); }
#endif
    V_ADDR_WB(addr, val);
    V_ADDR_WB(addr + 1, val >> 8);
    V_ADDR_WB(addr + 2, val >> 16);
    V_ADDR_WB(addr + 3, val >> 24);

I think there should be a #else to prevent executing of the WB statement
in little endian machines,am i missing something?

2.in xc/programs/Xserver/hw/xfree86/common/comiler.h
These statements seems wrong:
#define stq_u(v,p)      stl_u(v,p)
#define stl_u(v,p)      (*(unsigned char *)(p)) = (v); \
                        (*(unsigned char *)(p)+1) = ((v) >> 8);  \
                                           ^^^^^
                   Should it be (*((unsigned char*)(p) + 1))?
                        (*(unsigned char *)(p)+2) = ((v) >> 16); \
                        (*(unsigned char *)(p)+3) = ((v) >> 24)

#define stw_u(v,p)      (*(unsigned char *)(p)) = (v); \
                        (*(unsigned char *)(p)+1) = ((v) >> 8)


Mr. Guido Guenther has posted a patch to work around it.But could 
it be right somewhere?Just curious:)
  Thank you in advance.

Regards
            Fuxin Zhang
            fxzhang@ict.ac.cn
