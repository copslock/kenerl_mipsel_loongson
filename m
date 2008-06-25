Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2008 14:47:41 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:1550 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20041090AbYFYNre (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2008 14:47:34 +0100
Received: by mo.po.2iij.net (mo30) id m5PDksRQ009335; Wed, 25 Jun 2008 22:46:54 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox303) id m5PDkq9E030084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 25 Jun 2008 22:46:53 +0900
Date:	Wed, 25 Jun 2008 22:46:53 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	linux-fbdev-devel@lists.sourceforge.net, ralf@linux-mips.org
Subject: Re: [PATCH][1/2] add new Cobalt LCD framebuffer driver
Message-Id: <20080625224653.35f4478a.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080624141515.f710969a.akpm@linux-foundation.org>
References: <20080624224654.1ef3d665.yoichi_yuasa@tripeaks.co.jp>
	<20080624141515.f710969a.akpm@linux-foundation.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Tue, 24 Jun 2008 14:15:15 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 24 Jun 2008 22:46:54 +0900
> Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> 
> > Add new Cobalt LCD framebuffer driver.
> > 
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > 
> >
> > ...
> >
> > +static ssize_t cobalt_lcdfb_read(struct fb_info *info, char __user *buf,
> > +				 size_t count, loff_t *ppos)
> > +{
> > +	char src[LCD_CHARS_MAX];
> > +	unsigned long pos;
> > +	int len, retval;
> > +
> > +	pos = *ppos;
> > +	if (pos >= LCD_CHARS_MAX)
> > +		return 0;
> > +
> > +	if (pos + count >= LCD_CHARS_MAX)
> > +		count = LCD_CHARS_MAX - pos;
> 
> I think if sizeof(pos) == sizeof(count), and `count' is sufficiently
> large (eg: 0xffffffff) then bad things will happen in this function.
> 
> > +	for (len = 0; len < count; len++) {
> > +		retval = lcd_busy_wait(info);
> > +		if (retval < 0)
> > +			break;
> > +
> > +		lcd_write_control(info, LCD_TEXT_POS(pos));
> > +
> > +		retval = lcd_busy_wait(info);
> > +		if (retval < 0)
> > +			break;
> > +
> > +		src[len] = lcd_read_data(info);
> > +		if (pos == 0x0f)
> > +			pos = 0x40;
> > +		else
> > +			pos++;
> > +	}
> > +
> > +	if (copy_to_user(buf, src, len))
> > +		return -EFAULT;
> > +
> > +	*ppos += len;
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t cobalt_lcdfb_write(struct fb_info *info, const char __user *buf,
> > +				  size_t count, loff_t *ppos)
> > +{
> > +	char dst[LCD_CHARS_MAX];
> > +	unsigned long pos;
> > +	int len, retval;
> > +
> > +	pos = *ppos;
> > +	if (pos >= LCD_CHARS_MAX)
> > +		return 0;
> > +
> > +	if (pos + count >= LCD_CHARS_MAX)
> > +		count = LCD_CHARS_MAX - pos;
> 
> Ditto.
> 
> > +	if (copy_from_user(dst, buf, count))
> > +		return -EFAULT;
> > +
> > +	for (len = 0; len < count; len++) {
> > +		retval = lcd_busy_wait(info);
> > +		if (retval < 0)
> > +			break;
> > +
> > +		lcd_write_control(info, LCD_TEXT_POS(pos));
> > +
> > +		retval = lcd_busy_wait(info);
> > +		if (retval < 0)
> > +			break;
> > +
> > +		lcd_write_data(info, dst[len]);
> > +		if (pos == 0x0f)
> > +			pos = 0x40;
> > +		else
> > +			pos++;
> > +	}
> > +
> > +	*ppos += len;
> > +
> > +	return len;
> > +}
> 
> Is there any real benefit in this handling of signal_pending()?  afaict
> it is done correctly, but why did we bother doing it?
> 

Thank you for your comments.
I'll update it.

Yoichi
