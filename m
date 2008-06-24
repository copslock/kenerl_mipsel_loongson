Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 22:15:32 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56514 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S28573828AbYFXVP0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jun 2008 22:15:26 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5OLFFK8003175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jun 2008 14:15:16 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m5OLFFpC006422;
	Tue, 24 Jun 2008 14:15:15 -0700
Date:	Tue, 24 Jun 2008 14:15:15 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-fbdev-devel@lists.sourceforge.net,
	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][1/2] add new Cobalt LCD framebuffer driver
Message-Id: <20080624141515.f710969a.akpm@linux-foundation.org>
In-Reply-To: <20080624224654.1ef3d665.yoichi_yuasa@tripeaks.co.jp>
References: <20080624224654.1ef3d665.yoichi_yuasa@tripeaks.co.jp>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Tue, 24 Jun 2008 22:46:54 +0900
Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:

> Add new Cobalt LCD framebuffer driver.
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
>
> ...
>
> +static ssize_t cobalt_lcdfb_read(struct fb_info *info, char __user *buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	char src[LCD_CHARS_MAX];
> +	unsigned long pos;
> +	int len, retval;
> +
> +	pos = *ppos;
> +	if (pos >= LCD_CHARS_MAX)
> +		return 0;
> +
> +	if (pos + count >= LCD_CHARS_MAX)
> +		count = LCD_CHARS_MAX - pos;

I think if sizeof(pos) == sizeof(count), and `count' is sufficiently
large (eg: 0xffffffff) then bad things will happen in this function.

> +	for (len = 0; len < count; len++) {
> +		retval = lcd_busy_wait(info);
> +		if (retval < 0)
> +			break;
> +
> +		lcd_write_control(info, LCD_TEXT_POS(pos));
> +
> +		retval = lcd_busy_wait(info);
> +		if (retval < 0)
> +			break;
> +
> +		src[len] = lcd_read_data(info);
> +		if (pos == 0x0f)
> +			pos = 0x40;
> +		else
> +			pos++;
> +	}
> +
> +	if (copy_to_user(buf, src, len))
> +		return -EFAULT;
> +
> +	*ppos += len;
> +
> +	return len;
> +}
> +
> +static ssize_t cobalt_lcdfb_write(struct fb_info *info, const char __user *buf,
> +				  size_t count, loff_t *ppos)
> +{
> +	char dst[LCD_CHARS_MAX];
> +	unsigned long pos;
> +	int len, retval;
> +
> +	pos = *ppos;
> +	if (pos >= LCD_CHARS_MAX)
> +		return 0;
> +
> +	if (pos + count >= LCD_CHARS_MAX)
> +		count = LCD_CHARS_MAX - pos;

Ditto.

> +	if (copy_from_user(dst, buf, count))
> +		return -EFAULT;
> +
> +	for (len = 0; len < count; len++) {
> +		retval = lcd_busy_wait(info);
> +		if (retval < 0)
> +			break;
> +
> +		lcd_write_control(info, LCD_TEXT_POS(pos));
> +
> +		retval = lcd_busy_wait(info);
> +		if (retval < 0)
> +			break;
> +
> +		lcd_write_data(info, dst[len]);
> +		if (pos == 0x0f)
> +			pos = 0x40;
> +		else
> +			pos++;
> +	}
> +
> +	*ppos += len;
> +
> +	return len;
> +}

Is there any real benefit in this handling of signal_pending()?  afaict
it is done correctly, but why did we bother doing it?
