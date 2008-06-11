Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 00:24:44 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.156]:20446 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20040942AbYFKXYm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 00:24:42 +0100
Received: by yw-out-1718.google.com with SMTP id 9so1690999ywk.24
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2008 16:24:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=igQVFScsQAz5rH5aanlAlNbrqEX1ZWZruq2DvHEezow=;
        b=S9RDrVL6/Da23VdeFyIOi3zkvfn/MNShv4pZhNBYbNfe4ZbbuiA3iSsc6iMDeRG4bF
         vqdiBDAA3SIZa1RTEFYJo9ecNtg82q2hU8qXwdqOtFHfMAenDMwF6g89aB06Vaeih9We
         NoMxcvIFiQbsx+ffTwjHEF4W3CAQkYuXM1fCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=najfc6+uFswfjhA2qT6aB3WxJuIjiyqj2bF/EWXzPX3ZmEV/hVVNZx2Y9rU2ka4rLe
         fy5BjSYyhnWB8MryfueZl0NxUdjWCwiwLslnsZgAG0n4Dk8kuQeLHWwsBpgOeQAG6O+7
         +DiAL0FnkVUSHiR4o5Eh0PDJleVFDtoXi9vds=
Received: by 10.150.192.7 with SMTP id p7mr1135101ybf.91.1213226672307;
        Wed, 11 Jun 2008 16:24:32 -0700 (PDT)
Received: from scientist-2.local ( [66.78.193.51])
        by mx.google.com with ESMTPS id x56sm2000279pyg.10.2008.06.11.16.24.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Jun 2008 16:24:31 -0700 (PDT)
Message-ID: <48505EAC.6050404@gnu.org>
Date:	Wed, 11 Jun 2008 16:24:28 -0700
From:	Paolo Bonzini <bonzini@gnu.org>
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
MIME-Version: 1.0
To:	Maxim Kuvyrkov <maxim@codesourcery.com>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
Subject: Re: Changing the treatment of the MIPS HI and LO registers
References: <87tzgj4nh6.fsf@firetop.home> 	<Pine.LNX.4.55.0805272134540.18833@cliff.in.clinika.pl> 	<87abib4d9t.fsf@firetop.home> 	<Pine.LNX.4.55.0805272357020.18833@cliff.in.clinika.pl> 	<87r6bm1ebd.fsf@firetop.home> 	<Pine.LNX.4.55.0805290213140.29522@cliff.in.clinika.pl> 	<878wxtvarg.fsf@firetop.home> <8763stz2p3.fsf@firetop.home> <87zlpuxqfb.fsf@firetop.home> <48501C55.5060602@codesourcery.com>
In-Reply-To: <48501C55.5060602@codesourcery.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bonzini@gnu.org
Precedence: bulk
X-list: linux-mips

> GLIBC contains the following code in stdlib/longlong.h:
> <snip>
> #if defined (__mips__) && W_TYPE_SIZE == 32
> #define umul_ppmm(w1, w0, u, v) \
>   __asm__ ("multu %2,%3"                        \
>        : "=l" ((USItype) (w0)),                    \
>          "=h" ((USItype) (w1))                    \
>        : "d" ((USItype) (u)),                    \
>          "d" ((USItype) (v)))
> #define UMUL_TIME 10
> #define UDIV_TIME 100
> #endif /* __mips__ */
> </snip>

Actually, so does GCC itself.  Can you prepare a patch?

> What would be a correct fix in this case?  Something like this:
> <snip>
> #define umul_ppmm(w1, w0, u, v)                    \
>   ({unsigned int __attribute__((mode(DI))) __xx;        \
>     __xx = (unsigned int __attribute__((mode(DI)))) u * v;    \
>     w0 = __xx & ((1 << 32) - 1);                \
>     w1 = __xx >> 32;})
> </snip>
> 
> Or is there a better way?

Almost; this:

#define umul_ppmm(w1, w0, u, v)  \
   ({UDWtype __xx;       	 \
     UWtype __u = (u), __v = (v); \
     __xx = (UDWtype) __u * __v;  \
     w0 = (UWtype) __xx;          \
     w1 = __xx >> 32;})

should work.

Paolo
