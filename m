Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2014 23:56:36 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:45214 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832290AbaFEV4cESgQj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jun 2014 23:56:32 +0200
Received: by mail-ie0-f177.google.com with SMTP id y20so1521556ier.22
        for <multiple recipients>; Thu, 05 Jun 2014 14:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PTOsppSYOIeYvFvMLIMkHW+rFdK2qOWjn+BucvzmQtE=;
        b=YqF3X+tyRZaUtUGySGejZNKeaXbD+46EnmC95b5czOxsNivo0g7dcIn23e0B3LlVZn
         1NYNtBOTSqs/N1ZsPVt2gODaYXr/pqrcQuYizVYFt9XgQipoZfnulADwvLJ4IqcvCzLt
         4CtCN1rNoCczIiXvVMP3q8FBhw7QWuHeGsUJmy98Acbosr+WgXQuVUplM22SkgnQ/f6b
         CLO8QVdG6lXroj0nut4P6T2y171ej+NAcBujGQIfB1iWWi+EcJjRprD5e5hl5WgSjvIw
         OCkxZ4FXaPdmWddj3SQTLCvWeiWODLst0hMnPjEd+lhp+Eu2eo+8H1zjc5ZpDTabLXS1
         iwlA==
X-Received: by 10.50.114.197 with SMTP id ji5mr24730682igb.48.1402005385705;
        Thu, 05 Jun 2014 14:56:25 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id w4sm56085780igl.7.2014.06.05.14.56.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 14:56:25 -0700 (PDT)
Message-ID: <5390E788.2030702@gmail.com>
Date:   Thu, 05 Jun 2014 14:56:24 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: gcc warning in my trace_benchmark() code
References: <20140605121204.18ee5f2d@gandalf.local.home> <5390A4F0.3000601@gmail.com> <20140605133500.190eb31d@gandalf.local.home> <5390BA9D.3090402@gmail.com> <20140605145339.57c5be79@gandalf.local.home>
In-Reply-To: <20140605145339.57c5be79@gandalf.local.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/05/2014 11:53 AM, Steven Rostedt wrote:
> On Thu, 05 Jun 2014 11:44:45 -0700
> David Daney <ddaney.cavm@gmail.com> wrote:
>
>>> But stddev is s64. Ah, but the compare is:
>>>
>>> (void)(((typeof((n)) *)0) == ((uint64_t *)0));
>>>
>>> so it's complaining about a signed verses unsigned compare, not length.
>>> I think I can ignore this warning then.
>>
>> The pedant in me thinks that you should fix your code if using do_div()
>> on a signed object is undefined.  But if you aren't planning on merging
>> the code, then it probably doesn't matter.
>
> It's undefined on signed 64 numbers?

Evidently it is.

The top of asm-generic/div64.h has:

.
.
.
  * The semantics of do_div() are:
  *
  * uint32_t do_div(uint64_t *n, uint32_t base)
  * {
.
.
.

do_div() really passes the first parameter by reference, and C doesn't 
have by reference parameters, so the example is not quite right.  But it 
does seem to imply the thing should be an *unsigned* 64-bit wide variable.

It has been like this since the beginning of the git epoch.

> Where is that documented.

The code is the documentation.

> I don't
> see it in the comments, and I don't see anything in the Documentation
> directory. It only states that n must be 64bit. It doesn't say unsigned
> 64 bit.

The handful of call sites I examined, seem to all use u64 or unsigned 
long long.

I get:

   $ grep -r do_div Documentation | wc
       0       0       0

So it would seem that most of the do_div() documentation actually is the 
code.

David Daney
