Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 17:53:31 +0100 (BST)
Received: from ag-out-0708.google.com ([72.14.246.247]:10988 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S29052728AbYISQxY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Sep 2008 17:53:24 +0100
Received: by ag-out-0708.google.com with SMTP id 23so556905agd.7
        for <linux-mips@linux-mips.org>; Fri, 19 Sep 2008 09:53:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ac3/XzqwrJ3MF5SbS+7xCIat8HkkhUSuMACzAae+o1Y=;
        b=KRq1dm4tel3QsjMy5CpbV0+UkTBt75ohLJI7s/38rs06Xz5IVDO+2Rd9Ht8tCAnElW
         fXLt3jCI4Kq3fZhs7C1tcq5z7R6jlk4VKpqZ3qOkOZBculg3wawPw+pHI6El2yD903a0
         wpR0aqTXx23laB32VajWZTaWEpU9Xqj30qxWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Wi5G2+iA34tQIoJd98qVsSOjXhq9Uwz03K7+5Krr5i3AGNW9V4mnASKhxfBPB82gaR
         Rj5cGZkYH4Noe7yfL6oVtVsC8o5EQEAfG6tJCU6/BunqTjKvZzqL0G4HeKBl2B4T3QoJ
         BmDD7/jXRyFWaeoerxUc0jjo7EB8hY2gjzvQg=
Received: by 10.90.32.18 with SMTP id f18mr340744agf.30.1221843200310;
        Fri, 19 Sep 2008 09:53:20 -0700 (PDT)
Received: by 10.90.63.18 with HTTP; Fri, 19 Sep 2008 09:53:20 -0700 (PDT)
Message-ID: <a664af430809190953k486e2012hf3a09caa50c9574a@mail.gmail.com>
Date:	Fri, 19 Sep 2008 20:53:20 +0400
From:	"Dinar Temirbulatov" <dtemirbulatov@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: mmap is broken for MIPS64 n32 and o32 abis
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.55.0809191329080.29711@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a664af430809182331i41c9e344w83ecb2830ac24@mail.gmail.com>
	 <Pine.LNX.4.55.0809191329080.29711@cliff.in.clinika.pl>
Return-Path: <dtemirbulatov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dtemirbulatov@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,
The first address 0xb6000000 is a physical memory 32-bit address that
we are trying to map under n32 or o32 and it is valid.
         mmh = open("/dev/mem", O_RDWR | O_SYNC);
         if (mmh < 0) {
             .....
         }
         mmptr = (unsigned short *)mmap((void *)0, 0x1000,
                             PROT_READ | PROT_WRITE, MAP_SHARED,
                             mmh, 0xb6000000);
         ...

and the second one 0xffffffffb6000000 address is that old_mmap have
got on the kernel side when we do mmap under those abis,  calling
do_mmap2 after that with 0xffffffffb6000000 last parameter. This
example above works correctly only under n64 abi.

thanks, Dinar.

On Fri, Sep 19, 2008 at 4:33 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Fri, 19 Sep 2008, Dinar Temirbulatov wrote:
>
>> I noticed that mmap is not working properly under n32, o32 abis in
>> MIPS64, for example if we want to map 0xb6000000 address to the
>> userland under those abis we call  mmap and because the last argument
>> in old_mmap is off_t and this type is 64-bits wide for MIPS64, we end
>> up having for example 0xffffffffb6000000 address value. I am sure that
>> this is not a glibc issue. Following patch adds 32-bit version of mmap
>> and also it adds mmap64 support for n32 abi since mmap64 was
>> implemented correctly for n32 too.
>
>  Well, neither with the o32 nor with the n32 ABI are 0xb6000000 or
> 0xffffffffb6000000 (which is the n32's equivalent of the former) valid
> user addresses, so your concern is?
>
>  Maciej
>
