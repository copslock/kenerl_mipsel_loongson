Received:  by oss.sgi.com id <S42226AbQIVJ5J>;
	Fri, 22 Sep 2000 02:57:09 -0700
Received: from ppp0.ocs.com.au ([203.34.97.3]:15628 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S42222AbQIVJ5G>;
	Fri, 22 Sep 2000 02:57:06 -0700
Received: (qmail 23705 invoked from network); 22 Sep 2000 09:57:00 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 22 Sep 2000 09:57:00 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Brady Brown <bbrown@ti.com>,
        SGI news group <linux-mips@oss.sgi.com>
Subject: Re: ELF/Modutils problem 
In-reply-to: Your message of "Thu, 21 Sep 2000 15:36:31 +0200."
             <20000921153631.A1238@bacchus.dhis.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 22 Sep 2000 20:57:00 +1100
Message-ID: <1690.969616620@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 21 Sep 2000 15:36:31 +0200, 
Ralf Baechle <ralf@oss.sgi.com> wrote:
>On Wed, Sep 20, 2000 at 11:24:25AM +1100, Keith Owens wrote:
>> modutils 2.3.11 includes a sanity check on the number of local symbols
>> precisely because of this MIPS problem.  I agree with you that mips gcc
>> is violating the ELF standard, 2.3.11 just detects this and issues an
>> error message instead of overwriting memory but gcc needs to be fixed.
>
>And gcc has nothing to with it so it won't need to be fixed ...

Point taken, I should have said the MIPS toolchain instead of gcc.
Something in the toolchain is generating an ELF object that does not
follow the rules.  Can we catch someone's attention to get it fixed?
