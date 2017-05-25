Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 May 2017 08:55:07 +0200 (CEST)
Received: from mout.web.de ([212.227.15.3]:60090 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990924AbdEYGzAgAohd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 May 2017 08:55:00 +0200
Received: from [192.168.1.2] ([77.181.176.35]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LsQ9o-1dy0SP1dM0-011yBn; Thu, 25
 May 2017 08:54:49 +0200
Subject: Re: MIPS: Alchemy: Delete an error message for a failed memory
 allocation in alchemy_pci_probe()
To:     Manuel Lauss <manuel.lauss@gmail.com>, linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <6ebb5193-239f-5c34-c5f6-2be8a2fa79a5@users.sourceforge.net>
 <CAOLZvyHq-7q0XxiBsyX3q0g0J3kjfFv4SU7amX1hpjRDyK+feQ@mail.gmail.com>
 <796029e7-60a3-a94b-8b5c-4686a0656560@users.sourceforge.net>
 <CAOLZvyH-DF_r77kzcVcn+A-tTov+aNZ1oGNQLnGWXE35UODqtQ@mail.gmail.com>
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <70394897-a67a-2b49-2d46-a20fb2de51f2@users.sourceforge.net>
Date:   Thu, 25 May 2017 08:54:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAOLZvyH-DF_r77kzcVcn+A-tTov+aNZ1oGNQLnGWXE35UODqtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:hzChszYeHgIPFPB1HEBGBzHt7IjoTfECSfCzPEa8lxOR49OXkpN
 nf5GpbkLJO+BsQQDq3M2SOO4fC2a3SW2+eMOqV6mDmx3pV0Kh1OlA0SNu4yBYkF6ncl+sEu
 k5n/3dx7mWfoijynOx+fw/r3ZoOf4dD7mnSmdlTmuTjNLIV//nynriswqg2nY+8UfYc/rZY
 KKKa+WlVEvfhh1NmR5+3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BxRRZXWh0PQ=:mQpiD+CRPk5mFRzjUoU333
 /82rHhKZ76OJPC+cp1IgFUk7xt9kbMRQyRGRKj36cAr+ohQq0MGckCl7HVP6DsG7sD+fAacra
 qKG+OPSTexs4D0oq/LsmuikxStj3zXlaiL5pIWnhCEx/t41hPJS1I9CrH/OSRhS6LDfsxtYHy
 YlHF3Bl6jpMIFjhS04GHD0xGX3EFrZ/RT6vORZ0DYIZU72x3ZyeNHsxvD8If3rhRaCzeSSpOw
 wjBx3Sf5EHWdZ6zf2xPy8jXBMe0Z+fMHQ4CPbd5v999be+Ci/GuRPNfHTVagznctcUKH3oDx1
 6Xe8cC+a/jYHLPgFHFceXl7pUAoxxMlyhiUPm1E3MctS9Y3EHfaj//KQrDyJ7QIrCtXr8NOCw
 rSHK4rMM15lj4/SZP6YwwHhAgt2MqAKt34M95bpTf51h33tzWqHfyDvNKYxr/RfMi7tN5g43v
 YQfS/ZP6drT8I1P+5cv1yZpi7qVHZYXQwREOzYWZ6qamTTm9pHxv6yVmIboBILwFUo3ftue5n
 DKBhwU7oEoKm+GxxP86fzSEJYWNtEE/NOcnXpRdSeNfKmQUYdUjnDOp+7XiT0ZpmhA0nJmHva
 mZvuHKnqCv/uQcjRWuE/8m8SaR86qxGVPbYflKqLvM3eNBjGgjE5H1bIBeu+aVsR8lr6pVB+p
 c2gb8tRzxmsuaW0U8mrMWTsatS6Qkl9xw0wb14N2T+bNrwKQR5K4NwFx54rejUeTGawI1mk6K
 Dxl/W9BW9s+dflupRRbZRa/xV8SkR6vqByVr7MQf5seddYIe1CHROKQ2N8V2qMpHvUP5LsSg9
 SCnkynb
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

>> How do you think about to achieve a small code reduction also for this software module?
> 
> Generally speaking, sure.

Thanks for your interest in such a direction.


> But why remove just this one?  Is it because it loosely follows a
> pattern that was deemed removable in that slidedeck you linked to?

I derived another source code search approach from the implementation
of the check “OOM_MESSAGE” in the script “checkpatch.pl” for
the semantic patch language (Coccinelle software).
The involved search patterns are still evolving and the used lists
(or regular expressions) for function names where it might make sense
to reconsider the usage of special logging calls is therefore incomplete.


> (the "usb_submit_urb()" part)?

Would you like to extend the function selection for further considerations?


>> Do you find information from a Linux allocation failure report sufficient
>> for such a function implementation?
> 
> Yes, I wrote that code, and in case this driver doesn't load, I'd like
> to know precisely where initialization failed.
> I can happily spare a few bytes for that.

Does this kind of answer contain a bit of contradiction?

* Why do you seem to insist on another message if information from a Linux
  allocation failure report would be sufficient already also for this
  software module?

* Do you want that it can become easier to map a position in a backtrace
  to a place in your source code?

Regards,
Markus
