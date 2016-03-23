Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2016 19:43:00 +0100 (CET)
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34540 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009013AbcCWSm5wLObP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2016 19:42:57 +0100
Received: by mail-pf0-f181.google.com with SMTP id x3so36965339pfb.1
        for <linux-mips@linux-mips.org>; Wed, 23 Mar 2016 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+fOwFImrLofFSt5FAybLxcJri/xQZV38rtRjom4GpvY=;
        b=qKZkeKa77IRtTAzakn3SsB1C9r+5Nj1fzESMJAtHkV/TvUubLDs9rTydV6OdZ+0Aqm
         98RHGaCqL7UKYmCyU5SQiguCcL4ltlekRx3sPFM8Z5d8VOrDVoe2szHV3PeUrfTHmyGf
         1snXr+dI0YQY+MNRlypAHT3Yq6HaRpJS7QzY4G6SHP+wIfEXxsSI/pcUGgxeDOvEClL+
         JZiV7Lg3wtm/Mj5eIMJOXPObek1jp67FsWtNkt1b75wpbeqJnuEShzL6OPO88rDbIMv3
         WdXTUZmXr/SoIL+zMlqva8AUIlByuASMyyujJQU5cDjO9zbZISh6HJvuD1wbG4qk6/Mn
         E9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+fOwFImrLofFSt5FAybLxcJri/xQZV38rtRjom4GpvY=;
        b=Vljfoy52tjDVgvhk7gtKzvgGJdJZ5q18VxyDr4znm3yp3KBqNy4t0gkIs8cVAk+IPE
         SrQbnxo5pyENR37dqDa/Bml4ts5kGIGew4UkhsCqvqRKNQytrMQk8/tVgKBYgOHImAvg
         66MYtqe+e2UcMV96tEimmKqd1tGvWcYW7EQ/4Gwa/vZ3Jy03b8KT23ZErL86mxkmHmtx
         4ADKDo7pXKr7JM1mk42/hBAwkYfCjexpk2ifx5sSKJush+oO0N/bLWf0HJmxLqY2uspq
         wE6U3infgeidsTDbmapBOF65gEeFt9TzfN1KqD+FmpwZu+RBB+8Oej+cW0vAwKfHIV3j
         fNJA==
X-Gm-Message-State: AD7BkJIYlV71/CQWe6q02b+n3aU4qf3+JET9E7voPeApYWEQjq0RlOJsy2EMxYwDD3AUDw==
X-Received: by 10.98.66.75 with SMTP id p72mr6470884pfa.50.1458758571802;
        Wed, 23 Mar 2016 11:42:51 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1301:b076:2d7c:a575:26b9])
        by smtp.gmail.com with ESMTPSA id qh8sm5792691pac.40.2016.03.23.11.42.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 11:42:51 -0700 (PDT)
Date:   Wed, 23 Mar 2016 11:42:48 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-parisc@vger.kernel.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 14/16] input: Redefine INPUT_COMPAT_TEST as
 in_compat_syscall()
Message-ID: <20160323184248.GA25479@dtor-ws>
References: <cover.1453759363.git.luto@kernel.org>
 <64480084bc652d5fa91bf5cd4be979e2f1e4cf11.1453759363.git.luto@kernel.org>
 <CAKdAkRQm6ADz5aCYAFxXcoGZ2zNFwTUXjMzZdNj-D2-YrYQtrg@mail.gmail.com>
 <CALCETrUUNM1Qoqna1e7qmEqNUwo99PJe9fSuXG4fzPdSBLfPuA@mail.gmail.com>
 <20160127210610.GB28687@dtor-ws>
 <20160322135152.78d21ee6d56b702f06c5e01f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160322135152.78d21ee6d56b702f06c5e01f@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

On Tue, Mar 22, 2016 at 01:51:52PM -0700, Andrew Morton wrote:
> On Wed, 27 Jan 2016 13:06:10 -0800 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Wed, Jan 27, 2016 at 12:29:14PM -0800, Andy Lutomirski wrote:
> > > On Wed, Jan 27, 2016 at 11:17 AM, Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > > Hi Andy,
> > > >
> > > > On Mon, Jan 25, 2016 at 2:24 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > > >> The input compat code should work like all other compat code: for
> > > >> 32-bit syscalls, use the 32-bit ABI and for 64-bit syscalls, use the
> > > >> 64-bit ABI.  We have a helper for that (in_compat_syscall()): just
> > > >> use it.
> > > >>
> > > >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > > >> ---
> > > >>  drivers/input/input-compat.h | 12 +-----------
> > > >>  1 file changed, 1 insertion(+), 11 deletions(-)
> > > >>
> > > >> diff --git a/drivers/input/input-compat.h b/drivers/input/input-compat.h
> > > >> index 148f66fe3205..0f25878d5fa2 100644
> > > >> --- a/drivers/input/input-compat.h
> > > >> +++ b/drivers/input/input-compat.h
> > > >> @@ -17,17 +17,7 @@
> > > >>
> > > >>  #ifdef CONFIG_COMPAT
> > > >>
> > > >> -/* Note to the author of this code: did it ever occur to
> > > >> -   you why the ifdefs are needed? Think about it again. -AK */
> > > >> -#if defined(CONFIG_X86_64) || defined(CONFIG_TILE)
> > > >> -#  define INPUT_COMPAT_TEST is_compat_task()
> > > >> -#elif defined(CONFIG_S390)
> > > >> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_31BIT)
> > > >> -#elif defined(CONFIG_MIPS)
> > > >> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT_ADDR)
> > > >> -#else
> > > >> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT)
> > > >> -#endif
> > > >> +#define INPUT_COMPAT_TEST in_compat_syscall()
> > > >>
> > > >
> > > >
> > > > If we now have function that works on all arches I'd prefer if we used
> > > > it directly instead of continuing using INPUT_COMPAT_TEST.
> > > 
> > > I'll write a followup patch for that if you don't beat me to it.
> > 
> > I promise I wont ;)
> 
> Well someone needs beating!
> 
> I'm prepping this patch for Linus now.  I shall queue up the below for
> later.

Thank you Andrew.

> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: drivers/input: eliminate INPUT_COMPAT_TEST macro
> 
> INPUT_COMPAT_TEST became much simpler after "input: redefine
> INPUT_COMPAT_TEST as in_compat_syscall()" so we can cleanly eliminate it
> altogether.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> 
>  drivers/input/input-compat.c |    6 +++---
>  drivers/input/input-compat.h |    4 +---
>  drivers/input/input.c        |    2 +-
>  drivers/input/misc/uinput.c  |    4 ++--
>  4 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff -puN drivers/input/input-compat.h~a drivers/input/input-compat.h
> --- a/drivers/input/input-compat.h~a
> +++ a/drivers/input/input-compat.h
> @@ -17,8 +17,6 @@
>  
>  #ifdef CONFIG_COMPAT
>  
> -#define INPUT_COMPAT_TEST in_compat_syscall()
> -
>  struct input_event_compat {
>  	struct compat_timeval time;
>  	__u16 type;
> @@ -57,7 +55,7 @@ struct ff_effect_compat {
>  
>  static inline size_t input_event_size(void)
>  {
> -	return (INPUT_COMPAT_TEST && !COMPAT_USE_64BIT_TIME) ?
> +	return (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) ?
>  		sizeof(struct input_event_compat) : sizeof(struct input_event);
>  }
>  
> diff -puN drivers/input/misc/uinput.c~a drivers/input/misc/uinput.c
> --- a/drivers/input/misc/uinput.c~a
> +++ a/drivers/input/misc/uinput.c
> @@ -664,7 +664,7 @@ struct uinput_ff_upload_compat {
>  static int uinput_ff_upload_to_user(char __user *buffer,
>  				    const struct uinput_ff_upload *ff_up)
>  {
> -	if (INPUT_COMPAT_TEST) {
> +	if (in_compat_syscall()) {
>  		struct uinput_ff_upload_compat ff_up_compat;
>  
>  		ff_up_compat.request_id = ff_up->request_id;
> @@ -695,7 +695,7 @@ static int uinput_ff_upload_to_user(char
>  static int uinput_ff_upload_from_user(const char __user *buffer,
>  				      struct uinput_ff_upload *ff_up)
>  {
> -	if (INPUT_COMPAT_TEST) {
> +	if (in_compat_syscall()) {
>  		struct uinput_ff_upload_compat ff_up_compat;
>  
>  		if (copy_from_user(&ff_up_compat, buffer,
> diff -puN drivers/input/input-compat.c~a drivers/input/input-compat.c
> --- a/drivers/input/input-compat.c~a
> +++ a/drivers/input/input-compat.c
> @@ -17,7 +17,7 @@
>  int input_event_from_user(const char __user *buffer,
>  			  struct input_event *event)
>  {
> -	if (INPUT_COMPAT_TEST && !COMPAT_USE_64BIT_TIME) {
> +	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
>  		struct input_event_compat compat_event;
>  
>  		if (copy_from_user(&compat_event, buffer,
> @@ -41,7 +41,7 @@ int input_event_from_user(const char __u
>  int input_event_to_user(char __user *buffer,
>  			const struct input_event *event)
>  {
> -	if (INPUT_COMPAT_TEST && !COMPAT_USE_64BIT_TIME) {
> +	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
>  		struct input_event_compat compat_event;
>  
>  		compat_event.time.tv_sec = event->time.tv_sec;
> @@ -65,7 +65,7 @@ int input_event_to_user(char __user *buf
>  int input_ff_effect_from_user(const char __user *buffer, size_t size,
>  			      struct ff_effect *effect)
>  {
> -	if (INPUT_COMPAT_TEST) {
> +	if (in_compat_syscall()) {
>  		struct ff_effect_compat *compat_effect;
>  
>  		if (size != sizeof(struct ff_effect_compat))
> diff -puN drivers/input/input.c~a drivers/input/input.c
> --- a/drivers/input/input.c~a
> +++ a/drivers/input/input.c
> @@ -1015,7 +1015,7 @@ static int input_bits_to_string(char *bu
>  {
>  	int len = 0;
>  
> -	if (INPUT_COMPAT_TEST) {
> +	if (in_compat_syscall()) {
>  		u32 dword = bits >> 32;
>  		if (dword || !skip_empty)
>  			len += snprintf(buf, buf_size, "%x ", dword);
> _
> 

-- 
Dmitry
