Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 21:36:39 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.228]:58521 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021972AbXCSVgf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 21:36:35 +0000
Received: by wr-out-0506.google.com with SMTP id i31so1516912wra
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 14:35:30 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=i1AK34s97bV29jJNjzdqMN07GYNw300oMyRcJm5HSY7NGYGjb+UU0TvpK2+sBZyOEtJzkqoHE4q4p4mMJLS/jWKTqPMPq7Kb7O+4yRnHScsQU/AGpoLZAa8yFQl11Uj5qf9VmxxTaQaJzQkrx8f7EaBSfuV2kbdG5vPiVTTYL1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=gOxfm12vUQqIjJp6p84eOyceG1CdSJ7pjk0XIh48X8Mhu39T5Qa8o4vEYQJxFyCBgGS69hLlc3KrDo13bJY7dtqDDAj+9nE0bwud6nqXPkSba2jZnEF5rsG7xlC0Dw6Rt731eryaOCSJ8eZ9ryQTxrFMN1Kd37dMNKjwMXk42d8=
Received: by 10.90.90.16 with SMTP id n16mr82648agb.1174340130210;
        Mon, 19 Mar 2007 14:35:30 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 19 Mar 2007 14:35:29 -0700 (PDT)
Message-ID: <cda58cb80703191435u37ba4ed2se4cc150fcdb734a2@mail.gmail.com>
Date:	Mon, 19 Mar 2007 22:35:29 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	Kumba <kumba@gentoo.org>
Subject: Re: IP32 prom crashes due to __pa() funkiness
Cc:	"Linux MIPS List" <linux-mips@linux-mips.org>,
	"Arnaud Giersch" <arnaud.giersch@free.fr>
In-Reply-To: <45FE9D22.1030407@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_151232_23524980.1174340129950"
References: <45D8B070.7070405@gentoo.org>
	 <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>
	 <45FC46F0.3070300@gentoo.org> <87irczzglc.fsf@groumpf.homeip.net>
	 <45FC9E39.7010506@gentoo.org> <45FE95EE.5030108@innova-card.com>
	 <45FE9D22.1030407@gentoo.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_151232_23524980.1174340129950
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 3/19/07, Kumba <kumba@gentoo.org> wrote:
>
> Most of this is because IP22 (Indy/Idigo2 R4xx) and IP32 (O2 R5xxx), while
> supporting 64bit kernels (same for cobalt, since it's a mips4-level CPU), we had
> to "trick" them into accepting 64bit code.  IP32 at one point ran 32bit kernels
> only, but it was later converted to supporting only 64bit kernels, hence the
> hackery involved.  We describe it as wrapping 64bit code into a 32bit object,
> because their proms will only recognize 32bit objects (specifically, IP22 will
> only boot 32bit objects; crash on 64bit; IP32 will take both, but likes 32bit
> better).
>
> So really, CONFIG_BUILD_ELF64 was probably part of this "magic" to stuff 64bit
> code into a candy-coated 32bit wrapper for the Indy (And later the O2) to suck
> down w/o complaint.  Hence, __pa() probably needs to replicate this support, or
> we all need to brainstorm a proper way to get these systems to boot.
>

I'm really not confident with all your tricks you described. Maybe a
config that I believed to be uninsteresting and useless should be
supported still.

Can you try the attached patch with a plain linux-mips kernel ? This
patch restore CPHYSADDR() for 64 bits kernels _only_. I guess it's ok
because we won't need to support mapped kernels on 64 bits machines...

Could others give their opinions ?

> > I'm sorry but my IPxx background is 0 ;)
>
> Time to buy an O2 :)
>

As soon as it will work with a plain linux-mips without hackery ;)
-- 
               Franck

------=_Part_151232_23524980.1174340129950
Content-Type: text/x-patch; name=pa-64bits-kernel.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ezhfmxk3
Content-Disposition: attachment; filename="pa-64bits-kernel.patch"

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLW1pcHMvcGFnZS5oIGIvaW5jbHVkZS9hc20tbWlwcy9w
YWdlLmgKaW5kZXggZDNmYmQ4My4uNjQ2MTE1NCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hc20tbWlw
cy9wYWdlLmgKKysrIGIvaW5jbHVkZS9hc20tbWlwcy9wYWdlLmgKQEAgLTE0OSwxMiArMTQ5LDEy
IEBAIHR5cGVkZWYgc3RydWN0IHsgdW5zaWduZWQgbG9uZyBwZ3Byb3Q7IH0gcGdwcm90X3Q7CiAv
KgogICogX19wYSgpL19fdmEoKSBzaG91bGQgYmUgdXNlZCBvbmx5IGR1cmluZyBtZW0gaW5pdC4K
ICAqLwotI2lmIGRlZmluZWQoQ09ORklHXzY0QklUKSAmJiAhZGVmaW5lZChDT05GSUdfQlVJTERf
RUxGNjQpCi0jZGVmaW5lIF9fcGFfcGFnZV9vZmZzZXQoeCkJKCh1bnNpZ25lZCBsb25nKSh4KSA8
IENLU0VHMCA/IFBBR0VfT0ZGU0VUIDogQ0tTRUcwKQorI2lmZGVmIENPTkZJR182NEJJVAorI2Rl
ZmluZSBfX3BhKHgpCQkoKHVuc2lnbmVkIGxvbmcpKHgpIDwgQ0tTRUcwID8gWFBIWVNBRERSKCh1
bnNpZ25lZCBsb25nKSh4KSlcCisJCQkJCQkgICAgIDogQ1BIWVNBRERSKCh1bnNpZ25lZCBsb25n
KSh4KSkpCiAjZWxzZQotI2RlZmluZSBfX3BhX3BhZ2Vfb2Zmc2V0KHgpCVBBR0VfT0ZGU0VUCisj
ZGVmaW5lIF9fcGEoeCkJCSgodW5zaWduZWQgbG9uZykoeCkgLSBQQUdFX09GRlNFVCArIFBIWVNf
T0ZGU0VUKQogI2VuZGlmCi0jZGVmaW5lIF9fcGEoeCkJCSgodW5zaWduZWQgbG9uZykoeCkgLSBf
X3BhX3BhZ2Vfb2Zmc2V0KHgpICsgUEhZU19PRkZTRVQpCiAjZGVmaW5lIF9fdmEoeCkJCSgodm9p
ZCAqKSgodW5zaWduZWQgbG9uZykoeCkgKyBQQUdFX09GRlNFVCAtIFBIWVNfT0ZGU0VUKSkKICNk
ZWZpbmUgX19wYV9zeW1ib2woeCkJX19wYShSRUxPQ19ISURFKCh1bnNpZ25lZCBsb25nKSh4KSww
KSkKIAo=
------=_Part_151232_23524980.1174340129950--
