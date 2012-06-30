Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jun 2012 18:35:52 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:42897 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903618Ab2F3Qfr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jun 2012 18:35:47 +0200
Received: by pbbrq13 with SMTP id rq13so6526818pbb.36
        for <multiple recipients>; Sat, 30 Jun 2012 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Um/WtueF1s0uzssTP4NmVD1PDQkjw8Qf751dIMTuuho=;
        b=WKZbtmjeNGLCednPhJo9/uNX6oDgZXBNd6ZZntF4FDQMr4yoMfy8mRpWybbw18e94e
         RvhU2qH6JoQXKxoWDR793NBRR5gxfGQBMkBYyBl8IIzTpRNIydOfcARWSwV683ZfVXHs
         mpV4t+SPu+4TxS+pZEzA/R4b5z78ccWvgTpVwEQlXQPttghLQS4oNTMYgEej1imxI9ps
         wCluC+jVRuZ9OxSR/F6j+NMyhuqFdQr7RJ501TWtT7Nxdmu1zlbXPT4ga61H7l4FhMw2
         gVZ5cUUFuWpKUEunEP38o7k+RzQ23NFVt00hPtqD0MOo0J5pyhXm3ANzCgTpFPC6ZvL+
         gehQ==
Received: by 10.68.220.10 with SMTP id ps10mr15054571pbc.105.1341074140465;
 Sat, 30 Jun 2012 09:35:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.138.233 with HTTP; Sat, 30 Jun 2012 09:35:20 -0700 (PDT)
In-Reply-To: <CAEdQ38Ez+8DudAaJY7HZu9jbisk_KMbBO5h=s+P4pjJ0Va-zWw@mail.gmail.com>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
 <20110903103036.161616a5@endymion.delvare> <20111031105354.4b888e44@endymion.delvare>
 <20120110153834.531664db@endymion.delvare> <CAEdQ38FpG11m50pwg2=tu1fJRRg=zixFKLsPmVPOzWNBCjbNBg@mail.gmail.com>
 <20120331082346.26cc95cb@endymion.delvare> <CAEdQ38Ez+8DudAaJY7HZu9jbisk_KMbBO5h=s+P4pjJ0Va-zWw@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 30 Jun 2012 12:35:20 -0400
Message-ID: <CAEdQ38EDKndUcdBu1tZ_dOuhweVRW6aA=YKb6kUE3gUQJiwWoQ@mail.gmail.com>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of interrupts
To:     Jean Delvare <khali@linux-fr.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <guenter.roeck@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 33871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Mar 31, 2012 at 8:11 AM, Matt Turner <mattst88@gmail.com> wrote:
> On Sat, Mar 31, 2012 at 2:23 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> On Thu, 12 Jan 2012 16:19:49 -0500, Matt Turner wrote:
>>> On Tue, Jan 10, 2012 at 9:38 AM, Jean Delvare <khali@linux-fr.org> wrote:
>>> > On Mon, 31 Oct 2011 10:53:54 +0100, Jean Delvare wrote:
>>> >> On Sat, 3 Sep 2011 10:30:36 +0200, Jean Delvare wrote:
>>> >> > Please address my concerns where you agree and send an updated patch.
>>> >>
>>> >> Matt, care to send an updated patch addressing my concerns? Otherwise
>>> >> it will be lost again.
>>> >
>>> > It's been 3 more months. Matt (or anyone else who cares and has access
>>> > to the hardware), please send an updated patch or I'll have to drop it.
>>>
>>> I'll fix it up and resend the next time I'm working on the related mips stuff.
>>>
>>> It's hard to prioritize volunteer work for hardware you and two other
>>> people have. :)
>>
>> Matt, Maciej, does any of you have an updated patch ready by now? If I
>> don't receive anything by the end of April I'll just drop it.
>
> I'll do my best to get you an updated patch.
>
> Thanks for keeping after me.
>
> Matt

Hi Jean,

I'm not going to have time to do this. :(

I had another look at the code, and I'm not sure I really understand
it well enough to address your concerns.

Good thing there are only about three users with this motherboard.

Matt
