Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2005 14:12:01 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.183]:54522
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224991AbVBHOLp>; Tue, 8 Feb 2005 14:11:45 +0000
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CyW5c-0005H3-00; Tue, 08 Feb 2005 15:11:40 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1CyW5c-0000xg-00; Tue, 08 Feb 2005 15:11:40 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] au1100fb.c ported from 2.4 to 2.6
Date:	Tue, 8 Feb 2005 15:14:07 +0100
User-Agent: KMail/1.7.1
Cc:	Christian <c.pellegrin@exadron.com>
References: <1105523407.5654.18.camel@absolute.ascensit.com>
In-Reply-To: <1105523407.5654.18.camel@absolute.ascensit.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wkMCCPVzb3xx30p"
Message-Id: <200502081514.08186.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

--Boundary-00=_wkMCCPVzb3xx30p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Another two suggestions:

- you hard-coded the used display in au1100fb.{h,c} with #ifdef CONFIG_WWPC. 
There is another option already used in arch/mips/au1000/common/setup.c, and 
that is to append the necessary lines to the kernel commandline if no 
conflicting arguments are present.

- I have removed the comments that say to which field a constant belongs and 
instead converted au1100fb.h to use new-style initialisers which is just 
easier to not get wrong. I also added parameters for my display and replaced 
the #define for uint32. The new file is attached as whole, I didn't know 
against what to diff it...

Could you merge the file and resend the patch? I hope it will get committed 
then.


Uli

--Boundary-00=_wkMCCPVzb3xx30p
Content-Type: text/x-chdr;
  charset="iso-8859-1";
  name="au1100fb.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="au1100fb.h"

/*
 * BRIEF MODULE DESCRIPTION
 *	Hardware definitions for the Au1100 LCD controller
 *
 * Copyright 2002 MontaVista Software
 * Copyright 2002 Alchemy Semiconductor
 * Author:	Alchemy Semiconductor, MontaVista Software
 *
 *  This program is free software; you can redistribute	 it and/or modify it
 *  under  the terms of	 the GNU General  Public License as published by the
 *  Free Software Foundation;  either version 2 of the	License, or (at your
 *  option) any later version.
 *
 *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
 *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
 *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
 *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  You should have received a copy of the  GNU General Public License along
 *  with this program; if not, write  to the Free Software Foundation, Inc.,
 *  675 Mass Ave, Cambridge, MA 02139, USA.
 */

#ifndef _AU1100LCD_H
#define _AU1100LCD_H

/********************************************************************/

typedef volatile struct
{
	u32	lcd_control;
	u32	lcd_intstatus;
	u32	lcd_intenable;
	u32	lcd_horztiming;
	u32	lcd_verttiming;
	u32	lcd_clkcontrol;
	u32	lcd_dmaaddr0;
	u32	lcd_dmaaddr1;
	u32	lcd_words;
	u32	lcd_pwmdiv;
	u32	lcd_pwmhi;
	u32	reserved[(0x0400-0x002C)/4];
	u32	lcd_pallettebase[256];

} AU1100_LCD;

/********************************************************************/

#define AU1100_LCD_ADDR		0xB5000000

/*
 * Register bit definitions
 */

/* lcd_control */

#define LCD_CONTROL_SBB_1       (0<<21)
#define LCD_CONTROL_SBB_2       (1<<21)
#define LCD_CONTROL_SBB_3       (2<<21)
#define LCD_CONTROL_SBB_4       (3<<21)

#define LCD_CONTROL_SBPPF		(7<<18)
#define LCD_CONTROL_SBPPF_655	(0<<18)
#define LCD_CONTROL_SBPPF_565	(1<<18)
#define LCD_CONTROL_SBPPF_556	(2<<18)
#define LCD_CONTROL_SBPPF_1555	(3<<18)
#define LCD_CONTROL_SBPPF_5551	(4<<18)
#define LCD_CONTROL_WP			(1<<17)
#define LCD_CONTROL_WD			(1<<16)
#define LCD_CONTROL_C			(1<<15)
#define LCD_CONTROL_SM			(3<<13)
#define LCD_CONTROL_SM_0		(0<<13)
#define LCD_CONTROL_SM_90		(1<<13)
#define LCD_CONTROL_SM_180		(2<<13)
#define LCD_CONTROL_SM_270		(3<<13)
#define LCD_CONTROL_DB			(1<<12)
#define LCD_CONTROL_CCO			(1<<11)
#define LCD_CONTROL_DP			(1<<10)
#define LCD_CONTROL_PO			(3<<8)
#define LCD_CONTROL_PO_00		(0<<8)
#define LCD_CONTROL_PO_01		(1<<8)
#define LCD_CONTROL_PO_10		(2<<8)
#define LCD_CONTROL_PO_11		(3<<8)
#define LCD_CONTROL_MPI			(1<<7)
#define LCD_CONTROL_PT			(1<<6)
#define LCD_CONTROL_PC			(1<<5)
#define LCD_CONTROL_BPP			(7<<1)
#define LCD_CONTROL_BPP_1		(0<<1)
#define LCD_CONTROL_BPP_2		(1<<1)
#define LCD_CONTROL_BPP_4		(2<<1)
#define LCD_CONTROL_BPP_8		(3<<1)
#define LCD_CONTROL_BPP_12		(4<<1)
#define LCD_CONTROL_BPP_16		(5<<1)
#define LCD_CONTROL_GO			(1<<0)

/* lcd_intstatus, lcd_intenable */
#define LCD_INT_SD				(1<<7)
#define LCD_INT_OF				(1<<6)
#define LCD_INT_UF				(1<<5)
#define LCD_INT_SA				(1<<3)
#define LCD_INT_SS				(1<<2)
#define LCD_INT_S1				(1<<1)
#define LCD_INT_S0				(1<<0)

/* lcd_horztiming */
#define LCD_HORZTIMING_HN2		(255<<24)
#define LCD_HORZTIMING_HN2_N(N)	(((N)-1)<<24)
#define LCD_HORZTIMING_HN1		(255<<16)
#define LCD_HORZTIMING_HN1_N(N)	(((N)-1)<<16)
#define LCD_HORZTIMING_HPW		(63<<10)
#define LCD_HORZTIMING_HPW_N(N)	(((N)-1)<<10)
#define LCD_HORZTIMING_PPL		(1023<<0)
#define LCD_HORZTIMING_PPL_N(N)	(((N)-1)<<0)

/* lcd_verttiming */
#define LCD_VERTTIMING_VN2		(255<<24)
#define LCD_VERTTIMING_VN2_N(N)	(((N)-1)<<24)
#define LCD_VERTTIMING_VN1		(255<<16)
#define LCD_VERTTIMING_VN1_N(N)	(((N)-1)<<16)
#define LCD_VERTTIMING_VPW		(63<<10)
#define LCD_VERTTIMING_VPW_N(N)	(((N)-1)<<10)
#define LCD_VERTTIMING_LPP		(1023<<0)
#define LCD_VERTTIMING_LPP_N(N)	(((N)-1)<<0)

/* lcd_clkcontrol */
#define LCD_CLKCONTROL_IB		(1<<18)
#define LCD_CLKCONTROL_IC		(1<<17)
#define LCD_CLKCONTROL_IH		(1<<16)
#define LCD_CLKCONTROL_IV		(1<<15)
#define LCD_CLKCONTROL_BF		(31<<10)
#define LCD_CLKCONTROL_BF_N(N)	(((N)-1)<<10)
#define LCD_CLKCONTROL_PCD		(1023<<0)
#define LCD_CLKCONTROL_PCD_N(N)	((N)<<0)

/* lcd_pwmdiv */
#define LCD_PWMDIV_EN			(1<<12)
#define LCD_PWMDIV_PWMDIV		(2047<<0)
#define LCD_PWMDIV_PWMDIV_N(N)	(((N)-1)<<0)

/* lcd_pwmhi */
#define LCD_PWMHI_PWMHI1		(2047<<12)
#define LCD_PWMHI_PWMHI1_N(N)	((N)<<12)
#define LCD_PWMHI_PWMHI0		(2047<<0)
#define LCD_PWMHI_PWMHI0_N(N)	((N)<<0)

/* lcd_pallettebase - MONOCHROME */
#define LCD_PALLETTE_MONO_MI		(15<<0)
#define LCD_PALLETTE_MONO_MI_N(N)	((N)<<0)

/* lcd_pallettebase - COLOR */
#define LCD_PALLETTE_COLOR_BI		(15<<8)
#define LCD_PALLETTE_COLOR_BI_N(N)	((N)<<8)
#define LCD_PALLETTE_COLOR_GI		(15<<4)
#define LCD_PALLETTE_COLOR_GI_N(N)	((N)<<4)
#define LCD_PALLETTE_COLOR_RI		(15<<0)
#define LCD_PALLETTE_COLOR_RI_N(N)	((N)<<0)

/* lcd_palletebase - COLOR TFT PALLETIZED */
#define LCD_PALLETTE_TFT_DC			(65535<<0)
#define LCD_PALLETTE_TFT_DC_N(N)	((N)<<0)

/********************************************************************/

struct known_lcd_panels
{
	uint32 xres;
	uint32 yres;
	uint32 bpp;
	unsigned char  panel_name[256];
	uint32 mode_control;
	uint32 mode_horztiming;
	uint32 mode_verttiming;
	uint32 mode_clkcontrol;
	uint32 mode_pwmdiv;
	uint32 mode_pwmhi;
	uint32 mode_toyclksrc;
	uint32 mode_backlight;
};

#if defined(__BIG_ENDIAN)
#  define LCD_DEFAULT_PIX_FORMAT LCD_CONTROL_PO_11
#else
#  define LCD_DEFAULT_PIX_FORMAT LCD_CONTROL_PO_00
#endif

/*
 * The fb driver assumes that AUX PLL is at 48MHz.  That can
 * cover up to 800x600 resolution; if you need higher resolution,
 * you should modify the driver as needed, not just this structure.
 */
struct known_lcd_panels panels[] =
{
#ifdef CONFIG_WWPC
	{ /* just the standard LCD */
		.xres = 240,
		.yres = 320,
		.bpp = 16,
		.panel_name = "WWPC LCD",
		.mode_control = 0x0006806A,
		.mode_horztiming = 0x0A1010EF,
		.mode_verttiming = 0x0301013F,
		.mode_clkcontrol = 0x00018001,
		.mode_pwmdiv = 0,
		.mode_pwmhi = 0,
		.mode_toyclksrc = 0, /* not used */
		.mode_backlight = 0 /* not used */
	}
#else
	{ /* Pb1100 LCDA: Sharp 320x240 TFT panel */
		.xres = 320,
		.yres = 240,
		.bpp = 16,
		.panel_name = "Sharp_320x240_16",
		.mode_control =
			( LCD_CONTROL_SBPPF_565
			| LCD_CONTROL_C
			| LCD_CONTROL_SM_0
			| LCD_DEFAULT_PIX_FORMAT
			| LCD_CONTROL_PT
			| LCD_CONTROL_PC
			| LCD_CONTROL_BPP_16 ),
		.mode_horztiming =
			( LCD_HORZTIMING_HN2_N(8)
			| LCD_HORZTIMING_HN1_N(60)
			| LCD_HORZTIMING_HPW_N(12)
			| LCD_HORZTIMING_PPL_N(320) ),
		.mode_verttiming =
			( LCD_VERTTIMING_VN2_N(5)
			| LCD_VERTTIMING_VN1_N(17)
			| LCD_VERTTIMING_VPW_N(1)
			| LCD_VERTTIMING_LPP_N(240) ),
		.mode_clkcontrol = LCD_CLKCONTROL_PCD_N(1),
		.mode_pwmdiv = 0,
		.mode_pwmhi = 0,
		.mode_toyclksrc =
			((1<<7) | (1<<6) | (1<<5)),
		.mode_backlight = 6
	},

	{ /* Hitachi SP14Q005 and possibly others */
		.xres = 320,
		.yres = 240,
		.bpp = 4,
		.panel_name = "Hitachi_SP14Qxxx",
		.mode_control =
			( LCD_CONTROL_C
			| LCD_CONTROL_BPP_4 ),
		.mode_horztiming =
			( LCD_HORZTIMING_HN2_N(1)
			| LCD_HORZTIMING_HN1_N(1)
			| LCD_HORZTIMING_HPW_N(1)
			| LCD_HORZTIMING_PPL_N(320) ),
		.mode_verttiming =
			( LCD_VERTTIMING_VN2_N(1)
			| LCD_VERTTIMING_VN1_N(1)
			| LCD_VERTTIMING_VPW_N(1)
			| LCD_VERTTIMING_LPP_N(240) ),
		.mode_clkcontrol = LCD_CLKCONTROL_PCD_N(4),
		.mode_pwmdiv = 0,
		.mode_pwmhi = 0,
		.mode_toyclksrc =
			((1<<27) | (1<<26) | (1<<25) | (1<<7) | (1<<6) | (1<<5)),
		.mode_backlight = 6
	},

	{ /* Pb1100 LCDC 640x480 TFT panel */
		.xres = 640,
		.yres = 480,
		.bpp = 16,
		.panel_name = "Generic_640x480_16",
		.mode_control = 0x004806a | LCD_DEFAULT_PIX_FORMAT,
		.mode_horztiming = 0x3434d67f,
		.mode_verttiming = 0x0e0e39df,
		.mode_clkcontrol = LCD_CLKCONTROL_PCD_N(1),
		.mode_pwmdiv = 0,
		.mode_pwmhi = 0,
		.mode_toyclksrc =
			((1<<7) | (1<<6) | (0<<5)),
		.mode_backlight = 7
	},

	{ /* Pb1100 LCDB 640x480 PrimeView TFT panel */
		.xres = 640,
		.yres = 480,
		.bpp = 16,
		.panel_name = "PrimeView_640x480_16",
		.mode_control = 0x0004886a | LCD_DEFAULT_PIX_FORMAT,
		.mode_horztiming = 0x0e4bfe7f,
		.mode_verttiming = 0x210805df,
		.mode_clkcontrol = 0x00038001,
		.mode_pwmdiv = 0,
		.mode_pwmhi = 0,
		.mode_toyclksrc =
			((1<<7) | (1<<6) | (0<<5)),
		.mode_backlight = 7
	},

	{ /* Pb1100 800x600x16bpp NEON CRT */
		.xres = 800,
		.yres = 600,
		.bpp = 16,
		.panel_name = "NEON_800x600_16",
		.mode_control = 0x0004886A | LCD_DEFAULT_PIX_FORMAT,
		.mode_horztiming = 0x005AFF1F,
		.mode_verttiming = 0x16000E57,
		.mode_clkcontrol = 0x00020000,
		.mode_pwmdiv = 0,
		.mode_pwmhi = 0,
		.mode_toyclksrc =
			((1<<7) | (1<<6) | (0<<5)),
		.mode_backlight = 7
	},

	{ /* Pb1100 640x480x16bpp NEON CRT */
		.xres = 640,
		.yres = 480,
		.bpp = 16,
		.panel_name = "NEON_640x480_16",
		.mode_control = 0x0004886A | LCD_DEFAULT_PIX_FORMAT,
		.mode_horztiming = 0x0052E27F,
		.mode_verttiming = 0x18000DDF,
		.mode_clkcontrol = 0x00020000,
		.mode_pwmdiv = 0,
		.mode_pwmhi = 0,
		.mode_toyclksrc =
			((1<<7) | (1<<6) | (0<<5)),
		.mode_backlight = 7
	},
#endif
};
#endif /* _AU1100LCD_H */

--Boundary-00=_wkMCCPVzb3xx30p--
