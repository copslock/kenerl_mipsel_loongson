Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 05:11:04 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:46795 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491877AbZKZELB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Nov 2009 05:11:01 +0100
Received: by pwi15 with SMTP id 15so263961pwi.24
        for <multiple recipients>; Wed, 25 Nov 2009 20:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=T+r39iZT/7czNuVkOhoLLSb+UfUBQTNbEfKp6stiIEs=;
        b=hoOMzxhg6/bVQynmurc6+eX4G68TwiBvsmaRmnX1j1LULlc4jCeDzyeZ67RTp5jPd7
         JNE0I7O4uUtLX48DW3r0z6VVaCl8694wpVmMMc67klYkmVkCLpMQllpZ0xJ3YAcVmK5+
         E9lU1MpMzWMioqyx37RJjSnKSZgmlbWi5mL+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I/qShdjpiWhFynb+avTk9VpUmLCynmj+j5ck7WoK9oX88zp8p+F9Yls1eM9wT/TCga
         pwHOoSPMag1/iztBQ/Gh7HDrYXbihipi5im7+WwT7DRklTTbZfN+VHlS4KfsHvSZTaeD
         XNfhcXKl+AES9mSFzEYyEnMmFv6kGwWou1FM4=
Received: by 10.114.187.8 with SMTP id k8mr17280595waf.220.1259208652355;
        Wed, 25 Nov 2009 20:10:52 -0800 (PST)
Received: from mailhub.coreip.homeip.net (c-24-6-153-137.hsd1.ca.comcast.net [24.6.153.137])
        by mx.google.com with ESMTPS id 21sm229296pxi.12.2009.11.25.20.10.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 20:10:51 -0800 (PST)
Date:   Wed, 25 Nov 2009 20:10:47 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Richard Purdie <rpurdie@rpsys.net>, lm-sensors@lm-sensors.org,
        linux-input@vger.kernel.org, linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, sfr@linuxcare.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] [loongson] yeeloong2f: add platform specific support
Message-ID: <20091126041047.GC23244@core.coreip.homeip.net>
References: <9ef5a0038ec5e9b584be8c960693c434a323620a.1258803311.git.wuzhangjin@gmail.com> <9ef5a0038ec5e9b584be8c960693c434a323620a.1258803311.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef5a0038ec5e9b584be8c960693c434a323620a.1258803311.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Wu,

Overall impression - several drivers crammed into one module, I wonder
if it could be split somewhat. Some input-related concerns below.

On Sat, Nov 21, 2009 at 08:08:40PM +0800, Wu Zhangjin wrote:
> +
> +/* hotkey input subdriver */
> +
> +static struct input_dev *yeeloong_hotkey_dev;
> +static int event, status;
> +
> +struct key_entry {
> +	char type;		/* See KE_* below */
> +	int event;		/* event from SCI */
> +	u16 keycode;		/* KEY_* or SW_* */
> +};
> +
> +enum { KE_KEY, KE_SW, KE_END };

I am going to post the sparse keymap library shortly, this driver could
use it too...

> +
> +static struct key_entry yeeloong_keymap[] = {
> +	{KE_SW, EVENT_LID, SW_LID},
> +	/* SW_VIDEOOUT_INSERT? not included in hald-addon-input! */
> +	{KE_KEY, EVENT_CRT_DETECT, KEY_PROG1},
> +	/* Seems battery subdriver should report it */
> +	{KE_KEY, EVENT_OVERTEMP, KEY_PROG2},

Does not seem to be an input event?

> +	/*{KE_KEY, EVENT_AC_BAT, KEY_BATTERY},*/
> +	{KE_KEY, EVENT_CAMERA, KEY_CAMERA},	/* Fn + ESC */
> +	{KE_KEY, EVENT_SLEEP, KEY_SLEEP},	/* Fn + F1 */
> +	/* Seems not clear? not included in hald-addon-input! */
> +	{KE_KEY, EVENT_BLACK_SCREEN, KEY_PROG3},	/* Fn + F2 */

Do you mean "lock screen"?

> +	{KE_KEY, EVENT_DISPLAY_TOGGLE, KEY_SWITCHVIDEOMODE},	/* Fn + F3 */
> +	{KE_KEY, EVENT_AUDIO_MUTE, KEY_MUTE},	/* Fn + F4 */
> +	{KE_KEY, EVENT_WLAN, KEY_WLAN},	/* Fn + F5 */
> +	{KE_KEY, EVENT_DISPLAY_BRIGHTNESS, KEY_BRIGHTNESSUP},	/* Fn + up */
> +	{KE_KEY, EVENT_DISPLAY_BRIGHTNESS, KEY_BRIGHTNESSDOWN},	/* Fn + down */
> +	{KE_KEY, EVENT_AUDIO_VOLUME, KEY_VOLUMEUP},	/* Fn + right */
> +	{KE_KEY, EVENT_AUDIO_VOLUME, KEY_VOLUMEDOWN},	/* Fn + left */
> +	{KE_END, 0}
> +};
> +

...

> +
> +static ssize_t
> +ignore_store(struct device *dev,
> +	     struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	return count;
> +}
> +
> +static ssize_t
> +show_hotkeystate(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d %d\n", event, status);
> +}
> +
> +static DEVICE_ATTR(state, 0444, show_hotkeystate, ignore_store);

Why do you need "ignore_store" and not just use NULL? Also why do you
need to export the state at all?

> +
> +static struct attribute *hotkey_attributes[] = {
> +	&dev_attr_state.attr,
> +	NULL
> +};
> +
> +static struct attribute_group hotkey_attribute_group = {
> +	.attrs = hotkey_attributes
> +};
> +
> +static int camera_set(int status)
> +{
> +	int value;
> +	static int camera_status;
> +
> +	if (status == 2)
> +		/* resume the old camera status */
> +		camera_set(camera_status);
> +	else if (status == 3) {
> +		/* revert the camera status */
> +		value = ec_read(REG_CAMERA_CONTROL);
> +		ec_write(REG_CAMERA_CONTROL, value | (1 << 1));
> +	} else {/* status == 0 or status == 1 */
> +		status = !!status;
> +		camera_status = ec_read(REG_CAMERA_STATUS);
> +		if (status != camera_status)
> +			camera_set(3);
> +	}
> +	return ec_read(REG_CAMERA_STATUS);
> +}
> +
> +#define I8042_STATUS_REG	0x64
> +#define I8042_DATA_REG		0x60
> +#define i8042_read_status() inb(I8042_STATUS_REG)
> +#define i8042_read_data() inb(I8042_DATA_REG)
> +#define I8042_STR_OBF		0x01
> +#define I8042_BUFFER_SIZE	16
> +
> +static void i8042_flush(void)
> +{
> +	int i;
> +
> +	while ((i8042_read_status() & I8042_STR_OBF)
> +		&& (i < I8042_BUFFER_SIZE)) {
> +		udelay(50);
> +		i8042_read_data();
> +		i++;
> +	}
> +}
> +
> +static int yeeloong_hotkey_init(struct device *dev)
> +{
> +	int ret;
> +	struct key_entry *key;
> +
> +	/* flush the buffer of keyboard */
> +	i8042_flush();

Why??? Why does this driver tries to touch stuff that does not belong to
it?

> +
> +	/* setup the system control interface */
> +	setup_sci();

No failures?

> +
> +	yeeloong_hotkey_dev = input_allocate_device();
> +
> +	if (!yeeloong_hotkey_dev)
> +		return -ENOMEM;

Error unwinding?

> +
> +	yeeloong_hotkey_dev->name = "HotKeys";
> +	yeeloong_hotkey_dev->phys = "button/input0";
> +	yeeloong_hotkey_dev->id.bustype = BUS_HOST;
> +	yeeloong_hotkey_dev->dev.parent = dev;
> +
> +	for (key = yeeloong_keymap; key->type != KE_END; key++) {
> +		switch (key->type) {
> +		case KE_KEY:
> +			set_bit(EV_KEY, yeeloong_hotkey_dev->evbit);
> +			set_bit(key->keycode, yeeloong_hotkey_dev->keybit);
> +			break;
> +		case KE_SW:
> +			set_bit(EV_SW, yeeloong_hotkey_dev->evbit);
> +			set_bit(key->keycode, yeeloong_hotkey_dev->swbit);
> +			break;
> +		}
> +	}
> +
> +	ret = input_register_device(yeeloong_hotkey_dev);
> +	if (ret) {
> +		input_free_device(yeeloong_hotkey_dev);
> +		return ret;
> +	}
-- 
Dmitry
