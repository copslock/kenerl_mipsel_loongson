Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BKRbS10679
	for linux-mips-outgoing; Mon, 11 Feb 2002 12:27:37 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BKRW910669
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 12:27:32 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g1BJQCn4010977;
	Mon, 11 Feb 2002 11:26:12 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g1BJQA5C010973;
	Mon, 11 Feb 2002 11:26:11 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Mon, 11 Feb 2002 11:26:10 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Karsten Merker <karsten@excalibur.cologne.de>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: DECstation keyboard mappings and XFree
In-Reply-To: <Pine.GSO.4.21.0202111604400.13432-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.10.10202111112070.5200-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> >  Then the kernel needs to be fixed -- raw scancodes should be passed as is
> > and the translation should be done in kbd_translate().  I'm adding it to
> > my to-do list (to be resolved soon, hopefully, together with the annoying
> > indefinite timeout when no keyboard is attached). 
> 
> The keyboard mid-layer assumes keycodes are in the range 1-127 (with some minor
> hack 0 can be made to work, cfr. Amiga keboards). Bit 7 is used to
> differentiate between up and down events. This means you cannot get keyboards
> with more than 128 keys to work (e.g. some specialized keyboards for old
> workstations).
> 
> Perhaps it's different in the new input layer. I don't know.

With the input layer the below is translated to what the console system
wants. 

struct input_event {
        struct timeval time;
        unsigned short type;
        unsigned short code;
        unsigned int value;
};

The type field tells us if it is a key or mouse movement etc. 

The code field is the value of the key. For example if you press the A key
you would get KEY_A. Now buttons and keys are considered the same thing.
Because of this their is a range for keys and a range for buttons. At
present you can have up to 255 types of keys. For buttons and keys you can
have 0x1ff buttons.

Here the value field represents the states the key press can be in:

0: The key has been released.

1: The key has been pressed.

2: The key has been pressed again.
